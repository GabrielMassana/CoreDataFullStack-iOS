//
//  CDFTableViewCell.h
//  CoreDataFullStack
//
//  Created by GabrielMassana on 26/01/2016.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDFPerson;

@interface CDFTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;

- (void)layoutByApplyingConstraints;

- (void)updateCellWithManagedobject:(CDFPerson *)person;

@end
