//
//  CDFInsertService.m
//  CoreDataFullStack
//
//  Created by GabrielMassana on 08/03/2016.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFInsertService.h"

@implementation CDFInsertService

+ (__kindof NSManagedObject *)insertNewObjectForEntityClass:(Class)entityClass
                                     inManagedObjectContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(entityClass)
                                         inManagedObjectContext:context];
}

@end
