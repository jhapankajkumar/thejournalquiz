//
//  Image.m
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "Image.h"

@implementation Image
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"imageId"
                                                       }];
}
@end
