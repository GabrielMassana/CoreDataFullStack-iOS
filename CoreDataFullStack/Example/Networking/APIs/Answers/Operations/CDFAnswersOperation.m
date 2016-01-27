//
//  CDFAnswersOperation.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 27/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFAnswersOperation.h"

#import "CNMSession.h"
#import "CNMRequest.h"
#import "CNMURLSessionDataTask.h"

@implementation CDFAnswersOperation

#pragma mark - Identifier

@synthesize identifier = _identifier;

- (NSString *)identifier
{
    if (!_identifier)
    {
        _identifier = [NSString stringWithFormat:@"CDFAnswersOperation"];
    }
    
    return _identifier;
}

#pragma mark - Start

- (void)start
{
    [super start];
    
    CNMRequest *request = [[CNMRequest alloc] init];
    request.URL = [NSURL URLWithString:@"https://api.stackexchange.com/2.2/answers?site=stackoverflow"];
    
    CNMURLSessionDataTask *task = [[CNMSession defaultSession] dataTaskFromRequest:request];
    
    task.onCompletion = ^void(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (!error)
        {
            // Raw data to JSON.
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options: NSJSONReadingMutableContainers
                                                                   error: nil];
            
            //Parse data here
            
            NSLog(@"isMainThread %d", [NSThread currentThread].isMainThread);
            
            //Completion
            NSLog(@"result %@", json);
            NSLog(@"result %@", [json objectForKey:@"items"]);
            
            NSArray *items = [json objectForKey:@"items"];
            
            NSLog(@"item %@", items[0]);
            
            [self didSucceedWithResult:items[1]];
        }
        else
        {
            NSLog(@"error %@", error);
        }
    };
    
    [task resume];
}

#pragma mark - Cancel

- (void)cancel
{
    [super cancel];
    
    [self didSucceedWithResult:nil];
}

@end
