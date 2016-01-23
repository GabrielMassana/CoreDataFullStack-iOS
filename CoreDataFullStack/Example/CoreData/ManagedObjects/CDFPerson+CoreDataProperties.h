//
//  CDFPerson+CoreDataProperties.h
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 23/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CDFPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDFPerson (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *personID;
@property (nullable, nonatomic, retain) CDFHouse *house;

@end

NS_ASSUME_NONNULL_END
