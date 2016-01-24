//
//  ViewController.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 23/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFViewController.h"

#import "CDFHouse.h"
#import "CDFPerson.h"
#import "CoreDataFullStack.h"

@interface CDFViewController ()

@end

@implementation CDFViewController

#pragma mark - ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self deleteOldObjects];
    
    [self insertNewObjects];
    
    [self retrieveObjects];
    
    [self countObjects];
}

#pragma mark - Examples

- (void)countObjects
{
    NSInteger houseCount = [CDFCountService retrieveEntriesCountForEntityClass:[CDFHouse class] managedObjectContext:[CDFCoreDataManager sharedInstance].managedObjectContext];
    
    NSInteger personCount = [CDFCountService retrieveEntriesCountForEntityClass:[CDFPerson class] managedObjectContext:[CDFCoreDataManager sharedInstance].managedObjectContext];
    
    NSLog(@"%@", @(houseCount));
    NSLog(@"%@", @(personCount));
}

- (void)deleteOldObjects
{
    [[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext performBlockAndWait:^
     {
         NSString *entityName = NSStringFromClass([CDFHouse class]);
         NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
         
         NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"houseID"
                                                              ascending:YES];
         
         [request setSortDescriptors:[[NSArray alloc] initWithObjects:sort, nil]];
         
         
         NSArray *entries = [[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext executeFetchRequest:request
                                                                                                    error:nil];
         for (CDFHouse *house in entries)
         {
             [[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext deleteObject:house];
         }
     }];
}

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

- (void)retrieveObjects
{
    NSString *entityName = NSStringFromClass([CDFHouse class]);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"houseID"
                                                             ascending:YES];
    
    [request setSortDescriptors:[[NSArray alloc] initWithObjects:sort, nil]];
    
    
    NSArray *entries = [[CDFCoreDataManager sharedInstance].managedObjectContext executeFetchRequest:request
                                                                                               error:nil];
    if (entries.count > 0)
    {
        NSLog(@"house = %@", (CDFHouse *)entries[0]);
        
        for (CDFPerson *person in ((CDFHouse *)entries[0]).persons)
        {
            NSLog(@"person = %@", person);
        }
    }
}

@end
