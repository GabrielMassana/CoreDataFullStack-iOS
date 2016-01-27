//
//  CDFParser.h
//  CoreDataFullStack
//
//  Created by Gabriel Massana on 27/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Parser abstract class.
 */
@interface CDFParser : NSObject

/**
 Convenience alloc/init that will return a parser instance.
 
 @return FSNParser instance.
 */
+ (instancetype)parser;

@end
