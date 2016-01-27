//
//  CDFAnswersAPIManager.h
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 27/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CoreOperation.h"

@interface CDFAnswersAPIManager : NSObject

+ (void)downloadAnswersFromStackoverflowWithSuccess:(COMOperationOnSuccess)success
                                            failure:(COMOperationOnFailure)failure;

@end
