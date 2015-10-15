//
//  DataFetchManager.h
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  Quesiton;

@class  ResponseData;

@interface DataFetchManager : NSObject

-(void)getQuizDataFromServerWithCompletionBlock:(void(^) (ResponseData* result,BOOL results, NSError *error))completionBlock;
@end
