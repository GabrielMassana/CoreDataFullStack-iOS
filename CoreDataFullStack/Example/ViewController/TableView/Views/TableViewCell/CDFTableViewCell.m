//
//  CDFTableViewCell.m
//  CoreDataFullStack
//
//  Created by GabrielMassana on 26/01/2016.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFTableViewCell.h"

#import "CDFPerson.h"

@implementation CDFTableViewCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

#pragma mark - Layout

- (void)layoutByApplyingConstraints
{
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)updateCellWithManagedobject:(CDFPerson *)person
{
    self.textLabel.text = person.name;
}

@end
