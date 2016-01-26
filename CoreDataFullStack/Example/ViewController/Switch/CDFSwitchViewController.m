//
//  ViewController.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 23/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFSwitchViewController.h"

#import "PureLayout.h"
#import "UIButton+BBCBackgroundColor.h"
#import "CDFEasyTestViewController.h"
#import "CDFTableViewViewController.h"
#import "CDFCollectionViewViewController.h"

@interface CDFSwitchViewController ()

@property (nonatomic, strong) UIButton *easyTestButton;
@property (nonatomic, strong) UIButton *tableViewButton;
@property (nonatomic, strong) UIButton *collectionButton;

@end

@implementation CDFSwitchViewController

#pragma mark - ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.easyTestButton];
    [self.view addSubview:self.tableViewButton];
    [self.view addSubview:self.collectionButton];
    
    /*----------------*/

    [self updateViewConstraints];
}

#pragma mark - Subviews

- (UIButton *)easyTestButton
{
    if (!_easyTestButton)
    {
        _easyTestButton = [UIButton newAutoLayoutView];
        
        [_easyTestButton bbc_backgroundColorNormal:[UIColor lightGrayColor]
                           backgroundColorSelected:[UIColor darkGrayColor]];
        
        [_easyTestButton setTitle:@"Easy Test Example"
                         forState:UIControlStateNormal];
        
        [_easyTestButton addTarget:self
                            action:@selector(easyTestButtonPressed:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _easyTestButton;
}

- (UIButton *)tableViewButton
{
    if (!_tableViewButton)
    {
        _tableViewButton = [UIButton newAutoLayoutView];
        
        [_tableViewButton bbc_backgroundColorNormal:[UIColor redColor]
                           backgroundColorSelected:[UIColor purpleColor]];
        
        [_tableViewButton setTitle:@"Table View Example"
                          forState:UIControlStateNormal];
        
        [_tableViewButton addTarget:self
                             action:@selector(tableViewButtonPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _tableViewButton;
}

- (UIButton *)collectionButton
{
    if (!_collectionButton)
    {
        _collectionButton = [UIButton newAutoLayoutView];
        
        [_collectionButton bbc_backgroundColorNormal:[UIColor orangeColor]
                             backgroundColorSelected:[UIColor greenColor]];
        
        [_collectionButton setTitle:@"Collection View Example"
                           forState:UIControlStateNormal];
        
        [_collectionButton addTarget:self
                              action:@selector(collectionButtonPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _collectionButton;
}

#pragma mark - Constraints

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    /*----------------*/
    
    [self.easyTestButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    
    [self.easyTestButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    [self.easyTestButton autoSetDimension:ALDimensionHeight
                                   toSize:70.0f];
    
    [self.easyTestButton autoPinEdgeToSuperviewEdge:ALEdgeTop
                                          withInset:64.0f];
    
    /*----------------*/
    
    [self.tableViewButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    
    [self.tableViewButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    [self.tableViewButton autoSetDimension:ALDimensionHeight
                                   toSize:70.0f];
    
    [self.tableViewButton autoPinEdge:ALEdgeTop
                               toEdge:ALEdgeBottom
                               ofView:self.easyTestButton];
    
    /*----------------*/
    
    [self.collectionButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    
    [self.collectionButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    [self.collectionButton autoSetDimension:ALDimensionHeight
                                     toSize:70.0f];
    
    [self.collectionButton autoPinEdge:ALEdgeTop
                               toEdge:ALEdgeBottom
                               ofView:self.tableViewButton];
}

#pragma mark - ButtonActions

- (void)easyTestButtonPressed:(UIButton *)sender
{
    [self.navigationController pushViewController:[[CDFEasyTestViewController alloc] init]
                                         animated:YES];
}

- (void)tableViewButtonPressed:(UIButton *)sender
{
    [self.navigationController pushViewController:[[CDFTableViewViewController alloc] init]
                                         animated:YES];
}

- (void)collectionButtonPressed:(UIButton *)sender
{
    [self.navigationController pushViewController:[[CDFCollectionViewViewController alloc] init]
                                         animated:YES];
}

@end
