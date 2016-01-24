//
//  CDFRetrievalService.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 24/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFRetrievalService.h"

#import "CoreDataFullStack.h"

@implementation CDFRetrievalService

#pragma mark - Multiple retrieval

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
                             fetchBatchSize:(NSUInteger)fetchBatchSize
                                 fetchLimit:(NSUInteger)fetchLimit
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSArray *entries = nil;
    
    NSString *entityName = NSStringFromClass(entityClass);
    
    if (entityName.length > 0)
    {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
        
        if (predicate)
        {
            [request setPredicate:predicate];
        }
        
        if (orderBy)
        {
            NSSortDescriptor *dateSort = [[NSSortDescriptor alloc] initWithKey:orderBy ascending:ascending];
            [request setSortDescriptors:[[NSArray alloc] initWithObjects:dateSort, nil]];
        }
        
        if (fetchBatchSize > 0)
        {
            [request setFetchBatchSize:fetchBatchSize];
        }
        
        if (fetchLimit > 0)
        {
            [request setFetchLimit:fetchLimit];
        }
        
        NSError *error = nil;
        
        @try
        {
            entries =  [managedObjectContext executeFetchRequest:request
                                                           error:&error];
        }
        @catch (NSException *exception)
        {
            //CoreData doesn't give us nice logs on exceptions so we have to log it out manually here.
            NSLog(@"** COREDATA EXCEPTION ** : %@", [exception description]);
            abort();
        }
        
        if (error)
        {
            NSLog(@"Error attempting to retrieve entries from table %@, pred %@, orderby %@, managedObjectContext %@, ascending %d: %@", entityName, predicate, orderBy, managedObjectContext, ascending, [error userInfo]);
        }
    }
    
    return entries;
    
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
                             fetchBatchSize:(NSUInteger)fetchBatchSize
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDFRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:predicate
                                                      orderBy:orderBy
                                               ascendingOrder:ascending
                                               fetchBatchSize:0
                                                   fetchLimit:0
                                         managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDFRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:predicate
                                                      orderBy:orderBy
                                               ascendingOrder:ascending
                                               fetchBatchSize:0
                                                   fetchLimit:0
                                         managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDFRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:nil
                                                      orderBy:nil
                                               ascendingOrder:NO
                                               fetchBatchSize:0
                                                   fetchLimit:0
                                         managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                             fetchBatchSize:(NSUInteger)fetchBatchSize
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDFRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:nil
                                                      orderBy:nil
                                               ascendingOrder:NO
                                               fetchBatchSize:fetchBatchSize
                                                   fetchLimit:0
                                         managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDFRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:predicate
                                                      orderBy:nil
                                               ascendingOrder:NO
                                               fetchBatchSize:0
                                                   fetchLimit:0
                                         managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                             fetchBatchSize:(NSUInteger)fetchBatchSize
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDFRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:predicate
                                                      orderBy:nil
                                               ascendingOrder:NO
                                               fetchBatchSize:0
                                                   fetchLimit:0
                                         managedObjectContext:managedObjectContext];
}

#pragma mark - Single retrieval

+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
                              predicate:(NSPredicate *)predicate
                                orderBy:(NSString *)orderBy
                         ascendingOrder:(BOOL)ascending
                   managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObject *managedObject = nil;
    
    NSArray *managedObjects = [CDFRetrievalService retrieveEntriesForEntityClass:entityClass
                                                                       predicate:predicate
                                                                         orderBy:orderBy
                                                                  ascendingOrder:ascending
                                                                  fetchBatchSize:0
                                                                      fetchLimit:1
                                                            managedObjectContext:managedObjectContext];
    
    
    if ([managedObjects count] > 0)
    {
        managedObject = [managedObjects objectAtIndex:0];
    }
    
    return managedObject;
}

+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
                   managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDFRetrievalService retrieveFirstEntryForEntityClass:entityClass
                                                       predicate:nil
                                                         orderBy:nil
                                                  ascendingOrder:NO
                                            managedObjectContext:managedObjectContext];
}

+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
                              predicate:(NSPredicate *)predicate
                   managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    
    return [CDFRetrievalService retrieveFirstEntryForEntityClass:entityClass
                                                       predicate:predicate
                                                         orderBy:nil
                                                  ascendingOrder:NO
                                            managedObjectContext:managedObjectContext];
    
}

@end
