//
//  CDFCollectionViewFetchedResultsController.h
//  CoreDataManager
//
//  Created by Gabriel Massana on 17/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import <CoreData/CoreData.h>

#import <UIKit/UIKit.h>

@protocol CDFCollectionViewFetchedResultsControllerDelegate <NSObject>

/**
 Informational call for when the FRC updates.
 */
- (void)didUpdateContent;

@end

@interface CDFCollectionViewFetchedResultsController : NSFetchedResultsController

/**
 CDFCollectionViewFetchedResultsController delegate.
 */
@property (nonatomic, weak) id<CDFCollectionViewFetchedResultsControllerDelegate> frcDelegate;

/**
 Collection view for the fetch result controller to update.
 */
@property (nonatomic, weak) UICollectionView *collectionView;

/**
 Specifies if the fetch result controller should update it's sections.
 */
@property (nonatomic , assign) BOOL shouldUpdateSections;

@end
