//
//  CDFCollectionViewFetchedResultsController.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 17/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFCollectionViewFetchedResultsController.h"

@interface CDFCollectionViewFetchedResultsController () <NSFetchedResultsControllerDelegate>

/**
 Array with all the items changes to be done.
 */
@property (nonatomic, strong) NSMutableArray *itemChanges;

/**
 Array with all the section changes to be done.
 */
@property (nonatomic, strong) NSMutableArray *sectionChanges;

@end

@implementation CDFCollectionViewFetchedResultsController

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.delegate = self;
        
        self.shouldUpdateSections = YES;
    }
    
    return self;
}

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
        
        self.shouldUpdateSections = YES;
    }
    
    return self;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    self.sectionChanges = [[NSMutableArray alloc] init];
    self.itemChanges = [[NSMutableArray alloc] init];
}


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    if (self.shouldUpdateSections)
    {
        NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
        
        change[@(type)] = @(sectionIndex);
        
        [self.sectionChanges addObject:change];
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
        {
            change[@(type)] = newIndexPath;
            
            break;
        }
        case NSFetchedResultsChangeDelete:
        {
            change[@(type)] = indexPath;
            
            break;
        }
        case NSFetchedResultsChangeUpdate:
        {
            change[@(type)] = indexPath;
            
            break;
        }
        case NSFetchedResultsChangeMove:
        {
            change[@(type)] = @[indexPath, newIndexPath];
            
            break;
        }
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.collectionView performBatchUpdates:^
     {
         for (NSDictionary *change in self.sectionChanges)
         {
             [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
              {
                  NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                  
                  switch(type)
                  {
                      case NSFetchedResultsChangeInsert:
                      {
                          [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                          
                          break;
                      }
                      case NSFetchedResultsChangeDelete:
                      {
                          [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                          
                          break;
                      }
                      case NSFetchedResultsChangeUpdate:
                      case NSFetchedResultsChangeMove:
                      {
                          break;
                      }
                  }
              }];
         }
         for (NSDictionary *change in self.itemChanges)
         {
             [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
              {
                  NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                  
                  switch(type)
                  {
                      case NSFetchedResultsChangeInsert:
                      {
                          [self.collectionView insertItemsAtIndexPaths:@[obj]];
                          
                          break;
                      }
                      case NSFetchedResultsChangeDelete:
                      {
                          [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                          
                          break;
                      }
                      case NSFetchedResultsChangeUpdate:
                      {
                          [self.collectionView reloadItemsAtIndexPaths:@[obj]];
                          
                          break;
                      }
                      case NSFetchedResultsChangeMove:
                      {
                          [self.collectionView moveItemAtIndexPath:obj[0]
                                                       toIndexPath:obj[1]];
                          
                          break;
                      }
                  }
              }];
        }
    }
                                  completion:^(BOOL finished)
    {
        self.itemChanges = nil;
        self.sectionChanges = nil;
        
        [self.frcDelegate didUpdateContent];
    }];
}

@end
