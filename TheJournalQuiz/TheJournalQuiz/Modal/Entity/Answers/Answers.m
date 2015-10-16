//
//  Answers.m
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "Answers.h"

@implementation Answers
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"answerId"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end
