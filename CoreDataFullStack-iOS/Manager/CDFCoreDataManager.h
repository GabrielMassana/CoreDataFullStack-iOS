//
//  CDFCoreDataManager.h
//  CoreDataFullStack
//
//  Created by GabrielMassana on 11/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

/**
 Manager Delegate to help build the stack.
 */
@protocol CDFCoreDataManagerDelegate <NSObject>

/**
 Asks for the Model name through the delegate.
 */
- (NSString *)coreDataModelName;

@end

/**
 Main Manager of the framework. This class will build the Core Data Stack.
 */
@interface CDFCoreDataManager : NSObject

/**
 ManagedObjectContext that is used to run in the Main Thread.
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

/**
 ManagedObjectContext used to insert, delete and update the database.
 
 It is also used to background thread operations.
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *backgroundManagedObjectContext;

/**
 CoreDataManager delegate.
 */
@property (nonatomic, weak) id <CDFCoreDataManagerDelegate> delegate;

/**
 Returns the global CDFCoreDataManager instance.
 
 @return CDFCoreDataManager instance.
 */
+ (instancetype)sharedInstance;

/**
 Saves the managedObjectContext.
 */
- (void)saveManagedObjectContext;

/**
 Saves the given managedObjectContext.
 
 @param context - the context to be saved.
 */
- (void)saveManagedObjectContext:(NSManagedObjectContext *)context;

/**
 Destroys all data from core data, tears down the stack and builds it up again.
 */
- (void)reset;

@end
