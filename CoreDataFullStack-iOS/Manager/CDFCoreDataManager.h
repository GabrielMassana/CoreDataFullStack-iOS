//
//  CDFCoreDataManager.h
//  Hot
//
//  Created by GabrielMassana on 11/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

/**
 
 */
@protocol CDFCoreDataManagerDelegate <NSObject>

/**
 
 */
- (NSString *)coreDataModelName;

@end

/**
 
 */
@interface CDFCoreDataManager : NSObject

/**
 
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

/**
 
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *backgroundManagedObjectContext;

/**
 
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
