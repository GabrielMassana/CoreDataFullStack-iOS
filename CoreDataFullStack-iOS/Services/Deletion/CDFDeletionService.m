//
//  CDFDeletionService.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 24/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFDeletionService.h"

#import "CoreDataFullStack.h"

@implementation CDFDeletionService

#pragma mark - Single

+ (void) deleteManagedObject:(NSManagedObject *)managedObject managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDFDeletionService deleteManagedObject:managedObject
                          saveAfterDeletion:YES
                       managedObjectContext:managedObjectContext];
}

+ (void) deleteManagedObject:(NSManagedObject *)managedObject
           saveAfterDeletion:(BOOL)saveAfterDeletion
        managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if (managedObject &&
        managedObjectContext)
    {
        [managedObjectContext deleteObject:managedObject];
        
        if (saveAfterDeletion)
        {
            if ([managedObjectContext save:nil])
            {
                //Force context to process pending changes as
                //cascading deletes may not be immediatly applied by coredata.
                [managedObjectContext processPendingChanges];
            }
        }
    }
}

#pragma mark - Multiple

+ (void) deleteEntriesForEntityClass:(Class)entityClass
                managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDFDeletionService deleteEntriesForEntityClass:entityClass
                                          predicate:nil
                                  saveAfterDeletion:YES
                               managedObjectContext:managedObjectContext];
}

+ (void) deleteEntriesForEntityClass:(Class)entityClass
                   saveAfterDeletion:(BOOL)saveAfterDeletion
                managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDFDeletionService deleteEntriesForEntityClass:entityClass
                                          predicate:nil
                                  saveAfterDeletion:saveAfterDeletion
                               managedObjectContext:managedObjectContext];
}

+ (void) deleteEntriesForEntityClass:(Class)entityClass
                           predicate:(NSPredicate *)predicate
                managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDFDeletionService deleteEntriesForEntityClass:entityClass
                                          predicate:predicate
                                  saveAfterDeletion:YES
                               managedObjectContext:managedObjectContext];
}

+ (void) deleteEntriesForEntityClass:(Class)entityClass
                           predicate:(NSPredicate *)predicate
                   saveAfterDeletion:(BOOL)saveAfterDeletion
                managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSArray *entities = [CDFRetrievalService retrieveEntriesForEntityClass:entityClass
                                                                 predicate:predicate
                                                      managedObjectContext:managedObjectContext];
    
    for (NSManagedObject *entity in entities)
    {
        [CDFDeletionService deleteManagedObject:entity
                              saveAfterDeletion:NO
                           managedObjectContext:managedObjectContext];
    }
    
    if (saveAfterDeletion)
    {
        if ([managedObjectContext save:nil])
        {
            //Force context to process pending changes as
            //cascading deletes may not be immediatly applied by coredata.
            [managedObjectContext processPendingChanges];
        }
    }
}

@end
