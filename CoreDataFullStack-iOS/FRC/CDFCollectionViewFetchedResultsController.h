//
//  CDFCollectionViewFetchedResultsController.h
//  CoreDataManager
//
//  Created by Gabriel Massana on 17/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import <CoreData/CoreData.h>

#import <UIKit/UIKit.h>

/**
 
 */
@protocol CDFCollectionViewFetchedResultsControllerDelegate <NSObject>

/**
 
 */
- (void)didUpdateContent;

@end

/**
 
 */
@interface CDFCollectionViewFetchedResultsController : NSFetchedResultsController

/**
 
 */
@property (nonatomic, weak) id<CDFCollectionViewFetchedResultsControllerDelegate> frcDelegate;

/**
 
 */
@property (nonatomic, weak) UICollectionView *collectionView;

/**
 
 */
@property (nonatomic , assign) BOOL shouldUpdateSections;

@end
