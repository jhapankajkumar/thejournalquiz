//
//  ResponseData.m
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "ResponseData.h"

@implementation ResponseData
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"responseID"
                                                       }];
}
@end
