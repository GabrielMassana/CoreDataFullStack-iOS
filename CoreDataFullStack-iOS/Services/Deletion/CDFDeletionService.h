//
//  CDFDeletionService.h
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 24/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

/**
 Help service to simplify deletion.
 */
@interface CDFDeletionService : NSObject

#pragma mark - Single

/**
 Deletes an nsmanagedobject from specfic context
 
 @param managedObject - to be deleted
 @param managedObjectContext - the context used to access the entries
 */
+ (void) deleteManagedObject:(NSManagedObject *)managedObject
        managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 Deletes an nsmanagedobject from specfic context
 
 @param managedObject - to be deleted
 @param saveAfterDeletion - used to determine if after deletion the managed object context should be saved
 @param managedObjectContext - the context used to access the entries
 */
+ (void) deleteManagedObject:(NSManagedObject *)managedObject
           saveAfterDeletion:(BOOL)saveAfterDeletion
        managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

#pragma mark - Multiple

/**
 Deletes entites from specfic context
 
 @param entityClass - a class value for the entity in core data
 @param managedObjectContext - the context used to access the entries
 */
+ (void) deleteEntriesForEntityClass:(Class)entityClass
                managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 Deletes entites from specfic context
 
 @param entityClass - a class value for the entity in core data
 @param saveAfterDeletion - used to determine if after deletion the managed object context should be saved
 @param managedObjectContext - the context used to access the entries
 */
+ (void) deleteEntriesForEntityClass:(Class)entityClass
                   saveAfterDeletion:(BOOL)saveAfterDeletion
                managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 Deletes entites that match the predicate from specfic context
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries deleted
 @param managedObjectContext - the context used to access the entries
 */
+ (void) deleteEntriesForEntityClass:(Class)entityClass
                           predicate:(NSPredicate *)predicate
                managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 Deletes entites that match the predicate from specfic context
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries deleted
 @param saveAfterDeletion - used to determine if after deletion the managed object context should be saved
 @param managedObjectContext - the context used to access the entries
 */
+ (void) deleteEntriesForEntityClass:(Class)entityClass
                           predicate:(NSPredicate *)predicate
                   saveAfterDeletion:(BOOL)saveAfterDeletion
                managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
