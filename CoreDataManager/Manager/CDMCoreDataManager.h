//
//  CDMCoreDataManager.h
//  Hot
//
//  Created by GabrielMassana on 11/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@protocol CDMCoreDataManagerDelegate <NSObject>

- (NSString *)coreDataModelName;

@end

@interface CDMCoreDataManager : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectContext *backgroundManagedObjectContext;

@property (nonatomic, weak) id <CDMCoreDataManagerDelegate> delegate;

/*
 Returns the global CDMCoreDataManager instance.
 
 @return CDMCoreDataManager instance.
 */
+ (instancetype)sharedInstance;

/*
 Saves the managedObjectContext.
 */
- (void)saveManagedObjectContext;

@end
