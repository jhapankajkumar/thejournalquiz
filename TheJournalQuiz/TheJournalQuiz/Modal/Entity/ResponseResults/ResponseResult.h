//
//  ResponseResult.h
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseData.h"
#import <JSONModel.h>
@interface ResponseResult : JSONModel

@property (nonatomic, strong)  NSNumber* rendered;
@property (nonatomic, assign)  BOOL  status;
@property (nonatomic, strong)  ResponseData*  response;

@end
