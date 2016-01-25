//
//  CDFCountService.h
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 24/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

/**
 Help service to simplify count.
 */
@interface CDFCountService : NSObject

/**
 Retrieves the count of entries from specfic context
 
 @param entityClass - a class value for the entity in core data
 @param managedObjectContext - the context used to access the entries
 
 @return count
 */
+ (NSUInteger) retrieveEntriesCountForEntityClass:(Class)entityClass
                             managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 Retrieves the count of entries that match the provided predicate's conditions from specfic context
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries returned
 @param managedObjectContext - the context used to access the entries
 
 @return count
 */
+ (NSUInteger) retrieveEntriesCountForEntityClass:(Class)entityClass
                                        predicate:(NSPredicate *)predicate
                             managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
