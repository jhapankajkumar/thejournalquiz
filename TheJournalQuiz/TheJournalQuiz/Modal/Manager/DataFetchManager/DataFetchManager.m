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
#import "ResponseData.h"
#import "ResponseResult.h"


@implementation DataFetchManager

-(void)getQuizDataFromServerWithCompletionBlock:(void(^) (ResponseData* result,BOOL results, NSError *error))completionBlock {
    
    NSURL *url = [NSURL URLWithString:BaseURL];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:ClientID password:Password];
    NSError *err;
    NSMutableURLRequest *req = [manager.requestSerializer requestWithMethod:@"GET" URLString:BaseURL parameters:nil error:&err];
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL   status =  [[responseObject objectForKey:@"status"] boolValue];
        if (status) {
                NSDictionary *response = (NSDictionary *)responseObject;
                ResponseResult *result = [[ResponseResult alloc] initWithDictionary: response error:nil];
                NSLog(@"Result %@",result);

            dispatch_async(dispatch_get_main_queue(), ^{
              completionBlock(result.response,YES,nil);
            });
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(nil,NO,error);
        });
    }];
    
    [operation start];
    
}

@end
