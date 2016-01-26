//
//  ViewController.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 23/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFSwitchViewController.h"

#import "CDFHouse.h"
#import "CDFPerson.h"
#import "CoreDataFullStack.h"

@interface CDFSwitchViewController ()

@end

@implementation CDFSwitchViewController

#pragma mark - ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self deleteOldObjects];
    
    [self countObjects];

    [self insertNewObjects];
    
    [self retrieveObjects];
    
    [self countObjects];
}

#pragma mark - DeleteExample

- (void)deleteOldObjects
{
    [[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext performBlockAndWait:^
     {
         [CDFDeletionService deleteEntriesForEntityClass:[CDFHouse class]
                                       saveAfterDeletion:YES
                                    managedObjectContext:[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext];
     }];
}

#pragma mark - InsertExample

- (void)insertNewObjects
{
    [[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext performBlockAndWait:^
    {
        CDFHouse *firstHouse = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CDFHouse class])
                                                           inManagedObjectContext:[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext];
        
        firstHouse.houseID = @"0";
        firstHouse.town = @"London";
        
        CDFPerson *firstPerson = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CDFPerson class])
                                                             inManagedObjectContext:[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext];
        
        firstPerson.personID = @"0";
        firstPerson.name = @"John";
        firstPerson.house = firstHouse;
        
        CDFPerson *secondPerson = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CDFPerson class])
                                                               inManagedObjectContext:[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext];
        
        secondPerson.personID = @"1";
        secondPerson.name = @"Marie";
        secondPerson.house = firstHouse;
        
        [[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext save:nil];
    }];
}

#pragma mark - RetrieveExample

- (void)retrieveObjects
{
    NSArray *entries = [CDFRetrievalService retrieveEntriesForEntityClass:[CDFHouse class]
                                                     managedObjectContext:[CDFCoreDataManager sharedInstance].managedObjectContext];

    // NSLog retrieve example
    if (entries.count > 0)
    {
        NSLog(@"house = %@", (CDFHouse *)entries[0]);
        
        for (CDFPerson *person in ((CDFHouse *)entries[0]).persons)
        {
            NSLog(@"person = %@", person);
        }
    }
}

#pragma mark - CountExample

- (void)countObjects
{
    NSInteger houseCount = [CDFCountService retrieveEntriesCountForEntityClass:[CDFHouse class] managedObjectContext:[CDFCoreDataManager sharedInstance].managedObjectContext];
    
    NSInteger personCount = [CDFCountService retrieveEntriesCountForEntityClass:[CDFPerson class] managedObjectContext:[CDFCoreDataManager sharedInstance].managedObjectContext];
    
    NSLog(@"houseCount: %@", @(houseCount));
    NSLog(@"personCount: %@", @(personCount));
}

@end