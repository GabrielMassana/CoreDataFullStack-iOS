//
//  CDFCoreDataManager.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 11/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import "CDFCoreDataManager.h"

static NSString *const CDFPersistentStoreDirectoryName = @"persistent-store";
static NSString *const CDFPersistentStoreFileExtension = @"sqlite";

@interface CDFCoreDataManager ()

/**
 The model internal URL.
 */
@property (nonatomic, strong) NSURL *modelURL;

/**
  ManagedObjectContext that is used as the default managedObjectContext
 */
@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;

/**
 ManagedObjectContext used to background threads.
 */
@property (nonatomic, strong, readwrite) NSManagedObjectContext *backgroundManagedObjectContext;

/**
 Core Data Stack Managed Object Model.
 */
@property (nonatomic, strong, readwrite) NSManagedObjectModel *managedObjectModel;

/**
 Persistent store coordinator used with the stack
 */
@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 Local store URL.
 */
@property (nonatomic, strong, readonly) NSURL *storeDirectoryURL;

/**
 Disk store URL.
 */
@property (nonatomic, strong, readonly) NSURL *storeURL;

/**
 Destroys all data from core data and tears down the stack.
 */
- (void)clear;

@end

@implementation CDFCoreDataManager

#pragma mark - SharedInstance

+ (instancetype)sharedInstance
{
    static CDFCoreDataManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedInstance = [[CDFCoreDataManager alloc] init];
                  });
    
    return sharedInstance;
}

#pragma mark - Getters

- (NSManagedObjectModel *)managedObjectModel
{
    if (!_managedObjectModel)
    {
        self.modelURL = [[NSBundle mainBundle] URLForResource:[self.delegate coreDataModelName]
                                                 withExtension:@"momd"];
        
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
    }
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!_persistentStoreCoordinator)
    {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        [self createPersistentStoreAndRetryOnError:YES];
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.undoManager = nil;
        
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectContext *)backgroundManagedObjectContext
{
    if (!_backgroundManagedObjectContext)
    {
        _backgroundManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        
        _backgroundManagedObjectContext.undoManager = nil;
        _backgroundManagedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
        
        [_backgroundManagedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification* notification)
         {
             NSManagedObjectContext *context = self.managedObjectContext;
             if (notification.object != context)
             {
                 [context performBlock:^()
                  {
                      [context mergeChangesFromContextDidSaveNotification:notification];
                  }];
             }
         }];
    }
    
    return _backgroundManagedObjectContext;
}

#pragma mark - Setup

- (void)createPersistentStoreAndRetryOnError:(BOOL)retry
{
    NSError *error = nil;
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:[self.storeDirectoryURL path]
                           isDirectory:NULL])
    {
        [fileManager createDirectoryAtURL:self.storeDirectoryURL
              withIntermediateDirectories:NO
                               attributes:nil
                                    error:&error];
    }
    
    if (!error)
    {
        [self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                      configuration:nil
                                                                URL:self.storeURL
                                                            options:options
                                                              error:&error];
    }
    
    if (error)
    {
        [self deletePersistentStore];
        
        if (retry)
        {
            NSLog(@"Unresolved persistent store coordinator error %@, %@", error, [error userInfo]);
            [self createPersistentStoreAndRetryOnError:NO];
        }
        else
        {
            NSLog(@"Serious error with persistent-store %@, %@", error, [error userInfo]);
        }
    }
}

- (NSURL *)storeDirectoryURL
{
    NSURL *applicationDocumentURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                            inDomains:NSUserDomainMask] lastObject];
    
    NSURL *storeDirectoryURL = [applicationDocumentURL URLByAppendingPathComponent:CDFPersistentStoreDirectoryName];
    
    return storeDirectoryURL;
}

- (void)deletePersistentStore
{
    [[NSFileManager defaultManager] removeItemAtURL:self.storeDirectoryURL
                                              error:nil];
}

- (NSURL *)storeURL
{
    NSString *modelFileName = [[self.modelURL lastPathComponent] stringByDeletingPathExtension];
    
    NSString *storeFilePath = [NSString stringWithFormat:@"%@.%@", modelFileName, CDFPersistentStoreFileExtension];
    
    NSURL *storeURL = [self.storeDirectoryURL URLByAppendingPathComponent:storeFilePath];
    
    return storeURL;
}

#pragma mark - Save

- (void)saveManagedObjectContext
{
    [self saveManagedObjectContext:self.managedObjectContext];
}

- (void)saveManagedObjectContext:(NSManagedObjectContext *)context
{
    NSError *error = nil;
    
    if (![context save:&error])
    {
        NSLog(@"Couldn't save context: %@", [error userInfo]);
    }
    else
    {
        //Force context to process pending changes as
        //cascading deletes may not be immediatly applied by coredata.
        [context processPendingChanges];
    }
}

#pragma mark - Reset

- (void)reset
{
    [self clear];
}

#pragma mark - Clear

- (void)clear
{
    self.backgroundManagedObjectContext = nil;
    self.managedObjectContext = nil;
    
    self.persistentStoreCoordinator = nil;
    self.managedObjectModel = nil;
    
    [self deletePersistentStore];
}

@end
