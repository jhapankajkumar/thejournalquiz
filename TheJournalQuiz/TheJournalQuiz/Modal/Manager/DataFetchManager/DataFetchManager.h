//
//  DataFetchManager.h
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  Question;
@class  QuizData;

@interface DataFetchManager : NSObject

/*
 * getQuizDataFromServerWithCompletionBlock : This functions helps us to quize data from server. This a block based function.
 * @params
 * @response
 - status - This is BOOL value, indicating the Regestration was sucessful or not, If YES, sucessful.
 - restult -  quize data received from sever
 - error - This gives an error in case user regestration fails, or if some thing is not set.
 */
-(void)getQuizDataFromServerWithCompletionBlock:(void(^) (QuizData* result,BOOL results, NSError *error))completionBlock;
@end
