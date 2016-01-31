//
//  CDFCollectionViewViewController.m
//  CoreDataFullStack
//
//  Created by GabrielMassana on 26/01/2016.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFCollectionViewViewController.h"

#import "CDFAnswersAPIManager.h"

@interface CDFCollectionViewViewController ()

@end

@implementation CDFCollectionViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [CDFAnswersAPIManager downloadAnswersFromStackoverflowWithSuccess:^(id result)
    {
        NSLog(@"result %@", @(((NSArray *)result).count));
    }
                                                              failure:nil];
}

@end
