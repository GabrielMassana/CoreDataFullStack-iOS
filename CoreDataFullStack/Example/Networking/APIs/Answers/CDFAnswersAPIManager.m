//
//  CDFAnswersAPIManager.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 27/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFAnswersAPIManager.h"

#import <CoreNetworking/CNMRequest.h>
#import <CoreNetworking/CNMSession.h>
#import <CoreNetworking/CNMURLSessionDataTask.h>

#import "CDFAnswersOperation.h"
#import "CDFAppDelegate.h"

@implementation CDFAnswersAPIManager

+ (void)downloadAnswersFromStackoverflowWithSuccess:(COMOperationOnSuccess)success
                                            failure:(COMOperationOnFailure)failure
{
    CDFAnswersOperation *operation = [[CDFAnswersOperation alloc] init];
    operation.operationQueueIdentifier = kCNMNetworkingOperationQueueTypeIdentifier;
    
    operation.onSuccess = success;
    
    operation.onFailure = failure;
    
    [[COMOperationQueueManager sharedInstance] addOperation:operation];
}

@end
