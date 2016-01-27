//
//  AppDelegate.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 23/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFAppDelegate.h"

#import "CoreDataFullStack.h"
#import "COMOperationQueueManager.h"

NSString *const kCNMNetworkingOperationQueueTypeIdentifier = @"kCNMNetworkingOperationQueueTypeIdentifier";

@interface CDFAppDelegate () <CDFCoreDataManagerDelegate>

@end

@implementation CDFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [CDFCoreDataManager sharedInstance].delegate = self;
    
    [self registerOperationQueues];

    return YES;
}

#pragma mark - CDFCoreDataManagerDelegate

- (NSString *)coreDataModelName
{
    return @"example";
}

#pragma mark - OperationQueues

- (void)registerOperationQueues
{
    //Network UI
    
    //Network Background
    NSOperationQueue *networkDataOperationQueue = [[NSOperationQueue alloc] init];
    networkDataOperationQueue.qualityOfService = NSQualityOfServiceBackground;
    networkDataOperationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    
    [[COMOperationQueueManager sharedInstance] registerOperationQueue:networkDataOperationQueue
                                             operationQueueIdentifier:kCNMNetworkingOperationQueueTypeIdentifier];
    
    //Media Download
    
    //Core Data Update
}

@end
