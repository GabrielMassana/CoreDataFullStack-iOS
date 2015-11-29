//
//  CDMCoreDataManager.m
//  Hot
//
//  Created by GabrielMassana on 11/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import "CDMCoreDataManager.h"

static NSString *const CDMPersistentStoreDirectoryName = @"persistent-store";
static NSString *const CDMPersistentStoreFileExtension = @"sqlite";

@interface CDMCoreDataManager ()

@property (nonatomic, strong) NSURL *modelURL;
@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readwrite) NSManagedObjectContext *backgroundManagedObjectContext;
@property (nonatomic, strong, readwrite) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong, readonly) NSURL *storeDirectoryURL;
@property (nonatomic, strong, readonly) NSURL *storeURL;

@end

@implementation CDMCoreDataManager

#pragma mark - SharedInstance

+ (instancetype)sharedInstance
{
    static CDMCoreDataManager *sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedInstance = [[CDMCoreDataManager alloc] init];
                  });
    
    return sharedInstance;
}

#pragma mark - Getters

- (NSManagedObjectModel *)managedObjectModel
{
    if (!_managedObjectModel)
    {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:[self.delegate coreDataModelName]
                                                  withExtension:@"momd"];
        
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
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
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }

    return _managedObjectContext;
}

- (NSManagedObjectContext *)backgroundManagedObjectContext
{
    if (!_backgroundManagedObjectContext)
    {
        _backgroundManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_backgroundManagedObjectContext setParentContext:self.managedObjectContext];
        
        [_backgroundManagedObjectContext setUndoManager:nil];
        [_backgroundManagedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
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
    
    NSURL *storeDirectoryURL = [applicationDocumentURL URLByAppendingPathComponent:CDMPersistentStoreDirectoryName];
    
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
    
    NSString *storeFilePath = [NSString stringWithFormat:@"%@.%@", modelFileName, CDMPersistentStoreFileExtension];
    
    NSURL *storeURL = [self.storeDirectoryURL URLByAppendingPathComponent:storeFilePath];
    
    return storeURL;
}

#pragma mark - Save

- (void)saveManagedObjectContext
{
    NSError *error = nil;
    
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Couldn't save context: %@", [error userInfo]);
    }
    else
    {
        //Force context to process pending changes as
        //cascading deletes may not be immediatly applied by coredata.
        [self.managedObjectContext processPendingChanges];
    }
}

@end
