//
//  AppDelegate.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 23/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFAppDelegate.h"

#import "CoreDataFullStack.h"

@interface CDFAppDelegate () <CDFCoreDataManagerDelegate>

@end

@implementation CDFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [CDFCoreDataManager sharedInstance].delegate = self;
    
    return YES;
}

#pragma mark - CDFCoreDataManagerDelegate

- (NSString *)coreDataModelName
{
    return @"example";
}

@end
