//
//  CDFTableViewFetchedResultsController.h
//  Hot
//
//  Created by Gabriel Massana on 22/11/15.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import <CoreData/CoreData.h>

#import <UIKit/UIKit.h>

/**
 
 */
@protocol CDFTableViewFetchedResultsControllerDelegate <NSObject>

/**
 
 */
- (void)didUpdateContent;

/**
 
 */
- (void)willUpdateCellAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CDFTableViewFetchedResultsController : NSFetchedResultsController

/**
 
 */
@property (nonatomic, weak) id<CDFTableViewFetchedResultsControllerDelegate> frcDelegate;

/**
 
 */
@property (nonatomic, weak) UITableView *tableView;

/**
 
 */
@property (nonatomic , assign) BOOL shouldUpdateSections;

/**
 
 */
@property (nonatomic, assign) UITableViewRowAnimation insertRowAnimation;

/**
 
 */
@property (nonatomic, assign) UITableViewRowAnimation deleteRowAnimation;

/**
 
 */
@property (nonatomic, assign) UITableViewRowAnimation updateRowAnimation;

/**
 
 */
@property (nonatomic, assign) UITableViewRowAnimation insertSectionAnimation;

/**
 
 */
@property (nonatomic, assign) UITableViewRowAnimation deleteSectionAnimation;

@end
