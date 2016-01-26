//
//  CDFTableViewViewController.m
//  CoreDataFullStack
//
//  Created by GabrielMassana on 26/01/2016.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFTableViewViewController.h"

#import "CDFTableViewFetchedResultsController.h"
#import "PureLayout.h"
#import "CDFPerson.h"
#import "CoreDataFullStack.h"
#import "CDFTableViewCell.h"

@interface CDFTableViewViewController () <UITableViewDataSource, UITableViewDelegate, CDFTableViewFetchedResultsControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CDFTableViewFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) NSArray *sortDescriptorsForFetchRequest;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;

@property (nonatomic, strong) UIBarButtonItem *addButton;

@end

@implementation CDFTableViewViewController

#pragma mark - ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = self.addButton;;
    
    [self updateViewConstraints];
    
    [self.tableView registerClass:[CDFTableViewCell class]
           forCellReuseIdentifier:[CDFTableViewCell reuseIdentifier]];
}

#pragma mark - Subviews

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [UITableView newAutoLayoutView];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }
    
    return _tableView;
}

- (UIBarButtonItem *)addButton
{
    if (!_addButton)
    {
        _addButton = [[UIBarButtonItem alloc] initWithTitle:@"+"
                                                      style:UIBarButtonItemStyleDone
                                                     target:self
                                                     action:@selector(addButtonPressed:)];
    }
    
    return _addButton;
}

#pragma mark - Constraints

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    /*----------------*/
    
    [self.tableView autoPinEdgesToSuperviewEdges];
}

#pragma mark - ButtonActions

- (void)addButtonPressed:(UIBarButtonItem *)sender
{
    [[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext performBlockAndWait:^
     {
         CDFPerson *person = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CDFPerson class])
                                                                inManagedObjectContext:[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext];
         
         srand((unsigned)time(0));
         NSInteger random = rand();
         
         person.personID = [NSString stringWithFormat:@"%@", @(random)];
         
         NSArray *namesArray = @[@"David", @"Paul", @"Peter", @"Laura", @"Harry", @"Isabella", @"Gabriel", @"Marta", @"George"];

         NSInteger nameIndex = random % ((namesArray.count) - 1);
         
         person.name = namesArray[nameIndex];
         
         [[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext save:nil];
     }];
}

#pragma mark - FetchResultsController

- (CDFTableViewFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController)
    {
        _fetchedResultsController = [[CDFTableViewFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest
                                                                                  managedObjectContext:[CDFCoreDataManager sharedInstance].managedObjectContext
                                                                                    sectionNameKeyPath:nil
                                                                                             cacheName:nil];
        _fetchedResultsController.frcDelegate = self;
        _fetchedResultsController.tableView = self.tableView;
        _fetchedResultsController.updateRowAnimation = UITableViewRowAnimationNone;
        
        [_fetchedResultsController performFetch:nil];
    }

    return _fetchedResultsController;
}

- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    fetchRequest.entity = [NSEntityDescription entityForName:NSStringFromClass([CDFPerson class])
                                      inManagedObjectContext:[CDFCoreDataManager sharedInstance].managedObjectContext];
    
    fetchRequest.sortDescriptors = self.sortDescriptorsForFetchRequest;
    
    return fetchRequest;
}

- (NSArray *)sortDescriptorsForFetchRequest
{
    NSSortDescriptor *indexSort = [NSSortDescriptor sortDescriptorWithKey:@"personID"
                                                                ascending:YES];
    
    return @[indexSort];
}

#pragma mark -  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger fetchedRowsCount = self.fetchedResultsController.fetchedObjects.count;
    
    return fetchedRowsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CDFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CDFTableViewCell reuseIdentifier]
                                                             forIndexPath:indexPath];

    CDFPerson *person = self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    [cell updateCellWithManagedobject:person];

    /*---------------------*/
    
    [cell layoutByApplyingConstraints];
    
    /*---------------------*/

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CDFPerson *person = self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    [[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext performBlockAndWait:^
     {
        CDFPerson *personToDelete = [CDFRetrievalService retrieveFirstEntryForEntityClass:[CDFPerson class]
                                                                                predicate:[NSPredicate predicateWithFormat:@"personID == %@", person.personID]
                                                                     managedObjectContext:[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext];
         
         [CDFDeletionService deleteManagedObject:personToDelete
                            managedObjectContext:[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext];
         
         [[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext save:nil];
     }];
}

#pragma mark - CDFTableViewFetchedResultsControllerDelegate

- (void)didUpdateContent
{
    NSLog(@"didUpdateContent");
}

- (void)willUpdateCellAtIndexPath:(NSIndexPath *)indexPath
{
    CDFPerson *person = self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    CDFTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [cell updateCellWithManagedobject:person];
}

@end
