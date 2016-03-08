//
//  CDFAnswerParser.m
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 27/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFAnswerParser.h"

#import "CDFAnswer.h"
#import "CDFRetrievalService.h"
#import "CDFInsertService.h"
#import "CDFCoreDataManager.h"

@implementation CDFAnswerParser

- (NSArray *)parseAnswers:(NSArray *)answersArray
{
    NSMutableArray *array = [NSMutableArray new];
    
    for (NSInteger index = 0; index < answersArray.count; index++)
    {
        CDFAnswer *answer = [self parseAnswer:answersArray[index]];
        
        if (answer)
        {
            [array addObject:answer];
        }
    }
    
    return array;
}

- (CDFAnswer *)parseAnswer:(NSDictionary *)answerItem
{
    NSNumber *answerID = [answerItem objectForKey:@"answer_id"];
    NSString *answerIDString = [NSString stringWithFormat:@"%@", answerID];
    
    CDFAnswer *answer = nil;
    answer = [CDFRetrievalService retrieveFirstEntryForEntityClass:[CDFAnswer class]
                                                         predicate:[NSPredicate predicateWithFormat:@"answerID == %@", answerIDString]
                                              managedObjectContext:[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext];
    
    if (!answer)
    {
        answer = [CDFInsertService insertNewObjectForEntityClass:[CDFAnswer class]
                                          inManagedObjectContext:[CDFCoreDataManager sharedInstance].backgroundManagedObjectContext];
        
        answer.answerID = answerIDString;
    }
    
    answer.isAccepted = [answerItem objectForKey:@"is_accepted"];
    
    return answer;
}

@end
