//
//  House+CoreDataProperties.h
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 23/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "House.h"

NS_ASSUME_NONNULL_BEGIN

@interface House (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *houseID;
@property (nullable, nonatomic, retain) NSString *town;
@property (nullable, nonatomic, retain) NSSet<Person *> *persons;

@end

@interface House (CoreDataGeneratedAccessors)

- (void)addPersonsObject:(Person *)value;
- (void)removePersonsObject:(Person *)value;
- (void)addPersons:(NSSet<Person *> *)values;
- (void)removePersons:(NSSet<Person *> *)values;

@end

NS_ASSUME_NONNULL_END
