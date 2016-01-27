//
//  CDFAnswerParser.h
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 27/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "CDFParser.h"

@interface CDFAnswerParser : CDFParser

- (NSArray *)parseAnswers:(NSDictionary *)answersDictionary;

@end
