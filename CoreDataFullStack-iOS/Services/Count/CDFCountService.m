//
//  CDFCountService.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 24/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFCountService.h"

#import "CoreDataFullStack.h"

@implementation CDFCountService

#pragma mark - Count

+ (NSUInteger) retrieveEntriesCountForEntityClass:(Class)entityClass
                                        predicate:(NSPredicate *)predicate
                             managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSUInteger count = 0;
    
    NSString *entityName = NSStringFromClass(entityClass);
    
    if (entityName.length > 0)
    {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
        
        if (predicate)
        {
            [request setPredicate:predicate];
        }
        
        NSError *error = nil;
        
        count = [managedObjectContext countForFetchRequest:request
                                                     error:&error];
        
        if (error)
        {
            NSLog(@"Error attempting to retrieve entries count from table %@ with pred %@: %@", entityName, predicate, [error userInfo]);
        }
        
    }
    
    return count;
    
}

+ (NSUInteger) retrieveEntriesCountForEntityClass:(Class)entityClass
                             managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDFCountService retrieveEntriesCountForEntityClass:entityClass
                                                     predicate:nil
                                          managedObjectContext:managedObjectContext];
}

@end
