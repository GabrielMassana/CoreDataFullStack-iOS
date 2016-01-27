//
//  CDFCollectionViewViewController.m
//  CoreDataFullStack
//
//  Created by GabrielMassana on 26/01/2016.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFCollectionViewViewController.h"

#import "CNMSession.h"
#import "CNMRequest.h"
#import "CNMURLSessionDataTask.h"
#import "CDFAnswersOperation.h"
#import "CDFAppDelegate.h"

@interface CDFCollectionViewViewController ()

@end

@implementation CDFCollectionViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    CDFAnswersOperation *operation = [[CDFAnswersOperation alloc] init];
    operation.operationQueueIdentifier = kCNMNetworkingOperationQueueTypeIdentifier;
    
    operation.onSuccess = ^(id result)
    {
        NSLog(@"result %@", result);
        NSLog(@"isMainThread %d", [NSThread currentThread].isMainThread);
    };
    
    [[COMOperationQueueManager sharedInstance] addOperation:operation];
    

    
}

@end
