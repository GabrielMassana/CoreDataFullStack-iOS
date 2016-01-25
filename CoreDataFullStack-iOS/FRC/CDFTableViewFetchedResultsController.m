//
//  CDFTableViewFetchedResultsController.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 22/11/15.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import "CDFTableViewFetchedResultsController.h"

@interface CDFTableViewFetchedResultsController () <NSFetchedResultsControllerDelegate>

@end

@implementation CDFTableViewFetchedResultsController

#pragma mark - Init

- (instancetype)initWithFetchRequest:(NSFetchRequest *)fetchRequest
                managedObjectContext:(NSManagedObjectContext *)context
                  sectionNameKeyPath:(NSString *)sectionNameKeyPath
                           cacheName:(NSString *)name
{
    self = [super initWithFetchRequest:fetchRequest
                  managedObjectContext:context
                    sectionNameKeyPath:sectionNameKeyPath
                             cacheName:name];
    
    if (self)
    {
        self.delegate = self;
        
        self.updateRowAnimation = UITableViewRowAnimationNone;
        
        self.shouldUpdateSections = YES;
    }
    
    return self;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
        {
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:self.insertRowAnimation];
            
            break;
        }
        case NSFetchedResultsChangeDelete:
        {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:self.deleteRowAnimation];
            break;
        }
        case NSFetchedResultsChangeUpdate:
        {
            [self.frcDelegate willUpdateCellAtIndexPath:indexPath];
            
            break;
        }
        case NSFetchedResultsChangeMove:
        {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:self.deleteRowAnimation];
            
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:self.insertRowAnimation];
            
            break;
        }
    }
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    if (self.shouldUpdateSections)
    {
        switch(type)
        {
            case NSFetchedResultsChangeInsert:
            {
                [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                              withRowAnimation:self.insertSectionAnimation];
                
                break;
            }
            case NSFetchedResultsChangeDelete:
            {
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                              withRowAnimation:self.deleteSectionAnimation];
                
                break;
            }
            case NSFetchedResultsChangeMove:
            case NSFetchedResultsChangeUpdate:
            {
                break;
            }
        }
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
    
    [self.frcDelegate didUpdateContent];
}

@end
