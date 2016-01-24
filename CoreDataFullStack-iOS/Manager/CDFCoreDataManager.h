//
//  CDFCoreDataManager.h
//  Hot
//
//  Created by GabrielMassana on 11/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@protocol CDFCoreDataManagerDelegate <NSObject>

/**
 Asks for the Model name through the delegate.
 */
- (NSString *)coreDataModelName;

@end

/**
 MAin Manager of the framework. This class will build the Core Data Stack.
 */
@interface CDFCoreDataManager : NSObject

/**
 ManagedObjectContext that is used to run in the Main Thread.
 
 @return Managed Object Context.
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

/**
 ManagedObjectContext used to insert, delete and update the database.
 
 It is also used to background thread operations.
 
 @return Managed Object Context
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *backgroundManagedObjectContext;

/**
 CoreDataManager delegate.
 */
@property (nonatomic, weak) id <CDFCoreDataManagerDelegate> delegate;

/*
 Returns the global CDFCoreDataManager instance.
 
 @return CDFCoreDataManager instance.
 */
+ (instancetype)sharedInstance;

/*
 Saves the managedObjectContext.
 */
- (void)saveManagedObjectContext;

@end
