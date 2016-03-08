//
//  CDFInsertService.h
//  CoreDataFullStack
//
//  Created by GabrielMassana on 08/03/2016.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

/**
 Help service to simplify data insert.
 */
@interface CDFInsertService : NSObject

/**
 Inserts a new entity for the given class.
 
 @param entityClass - a class value for the entity in core data.
 @param managedObjectContext - the context used to insert the new entity.
 */
+ (__kindof NSManagedObject *)insertNewObjectForEntityClass:(Class)entityClass
                                     inManagedObjectContext:(NSManagedObjectContext *)context;

@end
