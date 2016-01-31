//
//  CDFCollectionViewViewController.m
//  CoreDataFullStack
//
//  Created by GabrielMassana on 26/01/2016.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFCollectionViewViewController.h"

#import "CDFAnswersAPIManager.h"
#import "CDFCollectionViewFetchedResultsController.h"
#import "PureLayout.h"

@interface CDFCollectionViewViewController () <UICollectionViewDataSource, UICollectionViewDelegate, CDFCollectionViewFetchedResultsControllerDelegate>

@property (nonatomic, strong) UIBarButtonItem *refreshButton;

@end

@implementation CDFCollectionViewViewController

#pragma mark - ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self refreshAPI];
    
    self.navigationItem.rightBarButtonItem = self.refreshButton;

    [self updateViewConstraints];
}

#pragma mark - Subviews

- (UIBarButtonItem *)refreshButton
{
    if (!_refreshButton)
    {
        _refreshButton = [[UIBarButtonItem alloc] initWithTitle:@"REFRESH"
                                                      style:UIBarButtonItemStyleDone
                                                     target:self
                                                     action:@selector(refreshButtonPressed:)];
    }
    
    return _refreshButton;
}

#pragma mark - Constraints

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    /*----------------*/
    
}

#pragma mark - API

- (void)refreshAPI
{
    [CDFAnswersAPIManager downloadAnswersFromStackoverflowWithSuccess:^(id result)
     {
         NSLog(@"refreshAPI: %@ more answers", @(((NSArray *)result).count));
     }
                                                              failure:nil];
}

#pragma mark - ButtonActions

- (void)refreshButtonPressed:(UIButton *)sender
{
    [self refreshAPI];
}

#pragma mark - FetchResultsController


#pragma mark -  UICollectionViewDataSource

#pragma mark -  UICollectionViewDelegate

@end
