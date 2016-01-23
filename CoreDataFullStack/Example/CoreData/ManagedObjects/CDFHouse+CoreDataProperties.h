//
//  CDFHouse+CoreDataProperties.h
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 23/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CDFHouse.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDFHouse (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *houseID;
@property (nullable, nonatomic, retain) NSString *town;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *persons;

@end

@interface CDFHouse (CoreDataGeneratedAccessors)

- (void)addPersonsObject:(NSManagedObject *)value;
- (void)removePersonsObject:(NSManagedObject *)value;
- (void)addPersons:(NSSet<NSManagedObject *> *)values;
- (void)removePersons:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
