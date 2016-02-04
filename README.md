# CoreDataFullStack-iOS

[![Version](https://img.shields.io/cocoapods/v/CoreDataFullStack.svg?style=flat-square)](http://cocoapods.org/pods/CoreDataFullStack)
[![License](https://img.shields.io/cocoapods/l/CoreDataFullStack.svg?style=flat-square)](http://cocoapods.org/pods/CoreDataFullStack)
[![Platform](https://img.shields.io/cocoapods/p/CoreDataFullStack.svg?style=flat-square)](http://cocoapods.org/pods/CoreDataFullStack)
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/CoreDataFullStack.svg?style=flat-square)](http://cocoapods.org/pods/CoreDataFullStack)
[![Build Status](https://img.shields.io/travis/GabrielMassana/CoreDataFullStack-iOS/master.svg?style=flat-square)](https://travis-ci.org/GabrielMassana/CoreDataFullStack-iOS)

##   What is it?

Easiest way to build a Core Data full stack.

#### Stack

This project stack consists of two independent managed object contexts which are both connected to the same persistent store coordinator.  

![alt tag](http://floriankugler.com/images/cd-stack-3-d53fc6f6.png)

The Core Data stack used follows the Florian Kugler's third example from [this](http://floriankugler.com/2013/04/29/concurrent-core-data-stack-performance-shootout/) article.

Florian Kugler's investigation shows how this Core Data Stack is the faster one.


#### FetchedResultsController

Core data make sense to use with an FRC. The project comes with the basic FRC implementation for a table and collection view.

#### Accessing Core Data

TODO: The project will have a full suite to access the objects.

## Installation

#### Podfile

```ruby
platform :ios, '8.0'
pod 'CoreDataFullStack', '~> 0.4'
```

Then, run the following command:

```bash
$ pod install
```

#### Old school

Drag into your project the folder `/CoreDataFullStack-iOS`. That's all.

## How to

#### General rule

To modify the database (insert new object, delete, update) access via the background ```backgroundManagedObjectContext```.

To retrieve data to be shown in the UI access via the MainThread ```managedObjectContext```

###### IMPORTANT

To avoid crossing threads use ```performBlockAndWait:^``` with the ```backgroundManagedObjectContext```

```objc
	[[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext performBlockAndWait:^
    {
    	// Insert
    	// Delete
    	// Update
    }
```

Go to Edit Scheme.../ Arguments / Arguments Passed On Launch and add: ```-com.apple.CoreData.ConcurrencyDebug 1```

This line will tell you if you are crossing threads in your app.

To avoid problems be totally sure that your app is not crossing threads.

#### Stack Set up

```objc

//  AppDelegate.m

#import "CoreDataFullStack.h"

@interface AppDelegate () <CDFCoreDataManagerDelegate>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [CDFCoreDataManager sharedInstance].delegate = self;
    
    return YES;
}

#pragma mark - CDFCoreDataManagerDelegate

- (NSString *)coreDataModelName
{
    return @"ModelName";
}

```

#### Insert

Use CoreData system. It is really easy.

```objc

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

        [[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext save:nil];
    }];

```

#### Retrieve

```objc
    NSArray *entries = [CDFRetrievalService retrieveEntriesForEntityClass:[CDFHouse class] managedObjectContext:[CDFCoreDataManager sharedInstance].managedObjectContext];
```

#### Delete
```objc
    [[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext performBlockAndWait:^
     {
         [CDFDeletionService deleteEntriesForEntityClass:[CDFHouse class]
                                       saveAfterDeletion:YES
                                    managedObjectContext:[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext];
     }];
```

#### Count
```objc
	NSArray *entries = [CDFRetrievalService retrieveEntriesForEntityClass:[CDFHouse class]
                                                     managedObjectContext:[CDFCoreDataManager sharedInstance].managedObjectContext];
```
## License

CoreDataFullStack-iOS is released under the MIT license. Please see the file called LICENSE.

## Versions

```bash
$ git tag -a 0.4.0 -m 'Version 0.4.0'

$ git push --tags
```

## Author

Gabriel Massana

##Found an issue?

Please open a [new Issue here](https://github.com/GabrielMassana/CoreDataFullStack-iOS/issues/new) if you run into a problem specific to CoreDataFullStack-iOS, have a feature request, or want to share a comment.


