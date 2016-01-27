//
//  CDFAnswer+CoreDataProperties.h
//  
//
//  Created by Gabriel Massana on 27/1/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CDFAnswer.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDFAnswer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *answerID;
@property (nullable, nonatomic, retain) NSNumber *isAccepted;

@end

NS_ASSUME_NONNULL_END
