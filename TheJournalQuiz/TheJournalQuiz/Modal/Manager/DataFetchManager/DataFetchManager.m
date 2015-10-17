//
//  DataFetchManager.m
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#define  BaseURL @"http://api.thejournal.ie/v3/quiz/7"
#define  ClientID @"candidate"
#define  Password @"c4nd1dat37061n"

#import "DataFetchManager.h"
#import <AFNetworking.h>
#import <AFHTTPRequestOperation.h>
#import "QuizData.h"
#import "QuizResult.h"


@implementation DataFetchManager

-(void)getQuizDataFromServerWithCompletionBlock:(void(^) (QuizData* result,BOOL results, NSError *error))completionBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURL *url = [NSURL URLWithString:BaseURL];
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:ClientID password:Password];
        NSError *error;
        NSMutableURLRequest *req = [manager.requestSerializer requestWithMethod:@"GET" URLString:BaseURL parameters:nil error:&error];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:req];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            //check if data is recieved from server
            BOOL   status =  [[responseObject objectForKey:@"status"] boolValue];
            //if status is true
            if (status == true) {
                NSDictionary *response = (NSDictionary *)responseObject;
                QuizResult *result = [[QuizResult alloc] initWithDictionary: response error:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(result.response,YES,nil);
                });
            }
            else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(nil,YES,nil);
                });
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil,NO,error);
            });
        }];
        
        [operation start];
    });
}

@end
