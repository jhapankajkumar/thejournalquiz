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
#import "Quesiton.h"
#import "OCMapper.h"
#import "ResponseData.h"
#import "OCMapperConfig.h"
#import "ResponseResult.h"
#import "Personas.h"

@implementation DataFetchManager

-(void)getQuizDataFromServerWithCompletionBlock:(void(^) (ResponseData* result,BOOL results, NSError *error))completionBlock {
    
    // 1
    //http://api.thejournal.ie/v3/quiz/7
    
    [OCMapperConfig configure];
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
            NSDictionary *dictionary = (NSDictionary *)  [responseObject objectForKey:@"response"];
            ResponseData *data = [[ResponseData alloc]init];
            
        
            NSLog(@"%@",[dictionary objectForKey:@"id_type"]);
            data.responseID = [[dictionary objectForKey:@"id"] integerValue];
            
            data.id_type = [dictionary objectForKey:@"id_type"];
            data.type = [dictionary objectForKey:@"type"];
            data.title = [dictionary objectForKey:@"title"];
            data.created = [dictionary objectForKey:@"created"];
            data.updated = [dictionary objectForKey:@"updated"];
            data.author  = [dictionary objectForKey:@"author"];
            
            //Personas Initialization
            
            NSMutableArray *personaResponseArray = (NSMutableArray *) [dictionary objectForKey:@"personas"];
            NSMutableArray *questionsResponseArray = (NSMutableArray *) [dictionary objectForKey:@"questions"];
            
            data.personas = [self getPersonasDetailsFromDictionary:personaResponseArray];
            data.questions = [self getQuestionsDetailsFromArray:questionsResponseArray];
            
            
            // personas =
            // questions;
            
            dispatch_async(dispatch_get_main_queue(), ^{
              completionBlock(data,YES,nil);
            });
        }
        
        //NSLog(@"%d",responseResult);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(nil,NO,error);
        });
    }];
    
    // 5
    [operation start];
    
}

-(NSMutableArray *)getPersonasDetailsFromDictionary :(NSMutableArray *)personaArray {
    
    NSMutableArray *personasObjectArray = [[NSMutableArray alloc]init];
    for (NSDictionary * dictionary in personaArray) {
        
        Personas *persona = [[Personas alloc]init];
        persona.personaID = [[dictionary objectForKey:@"id"] integerValue];
        persona.id_type = [dictionary objectForKey:@"id_type"];
        persona.title = [dictionary objectForKey:@"title"];
        persona.text = [dictionary objectForKey:@"text"];
        persona.social = [dictionary objectForKey:@"social"];
        persona.max = [[dictionary objectForKey:@"max"] boolValue];
        persona.min = [[dictionary objectForKey:@"min"] boolValue];
        if ([[dictionary objectForKey:@"image"] isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *imageDictionary = [dictionary objectForKey:@"image"];
            
            //Persona Image Setup
            Image *image = [[Image alloc]init];
            image.imageId = [[imageDictionary objectForKey:@"id"] integerValue];
            image.src = [imageDictionary objectForKey:@"src"];
            image.object_id = [imageDictionary objectForKey:@"object_id"];
            image.object_type = [imageDictionary objectForKey:@"object_type"];
            image.version = [imageDictionary objectForKey:@"version"];
            persona.image = image;
        }
        else {
            persona.image = nil;
        }
        [personasObjectArray addObject:persona];
    }
    return personasObjectArray;
}


-(NSMutableArray *)getQuestionsDetailsFromArray :(NSMutableArray *)questionsArray {
    
    NSMutableArray *questionsObjectArray = [[NSMutableArray alloc]init];
    for (NSDictionary * questionDictionary in questionsArray) {
        
        Quesiton *question = [[Quesiton alloc]init];
        
        //setup question data
        question.questionID = [[questionDictionary objectForKey:@"id"] integerValue];
        question.id_type = [questionDictionary objectForKey:@"id_type"];
        question.text = [questionDictionary objectForKey:@"text"];
        
        //setup Answers
        NSMutableArray  *answerResponseArray = (NSMutableArray *) [questionDictionary objectForKey:@"answers"];
        
        //calling method to get answer array
        NSMutableArray *answerDataArray = [self getAnswerDetailsFromArray:answerResponseArray];
        question.answer = answerDataArray;
        
        //setup Question Image
        
        if ([[questionDictionary objectForKey:@"image"] isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *imageDictionary = [questionDictionary objectForKey:@"image"];
            Image *questionImage = [[Image alloc]init];
            questionImage.imageId = [[imageDictionary objectForKey:@"id"] integerValue];
            questionImage.src = [imageDictionary objectForKey:@"src"];
            questionImage.object_id = [imageDictionary objectForKey:@"object_id"];
            questionImage.object_type = [imageDictionary objectForKey:@"object_type"];
            questionImage.version = [imageDictionary objectForKey:@"version"];
            
            question.image = questionImage;
        }
        else {
            question.image = nil;
        }
        [questionsObjectArray addObject:question];
    }
    return questionsObjectArray;
}


-(NSMutableArray *)getAnswerDetailsFromArray :(NSMutableArray *)answerArray {
    
    NSMutableArray *questionsObjectArray = [[NSMutableArray alloc]init];
    for (NSDictionary * answerDictionary in answerArray) {
        
        Answers *answer = [[Answers alloc]init];
        //setup answer data
        answer.answerId = [[answerDictionary objectForKey:@"id"] integerValue];
        answer.id_type = [answerDictionary objectForKey:@"id_type"];
        answer.text = [answerDictionary objectForKey:@"text"];
        answer.score = [answerDictionary objectForKey:@"score"];
        answer.correct = [[answerDictionary objectForKey:@"correct"] boolValue];
        answer.persona_ids = (NSMutableArray *)[answerDictionary objectForKey:@"persona_ids"];
        
        
        //setup Image
        
        if ([[answerDictionary objectForKey:@"image"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *imageDictionary = [answerDictionary objectForKey:@"image"];
            
            //setup Question Image
            Image *answerImage = [[Image alloc]init];
            answerImage.imageId = [[imageDictionary objectForKey:@"id"] integerValue];
            answerImage.src = [imageDictionary objectForKey:@"src"];
            answerImage.object_id = [imageDictionary objectForKey:@"object_id"];
            answerImage.object_type = [imageDictionary objectForKey:@"object_type"];
            answerImage.version = [imageDictionary objectForKey:@"version"];
            answer.image = answerImage;
        }
        else {
            answer.image = nil;
        }
        
        [questionsObjectArray addObject:answer];
    }
    return questionsObjectArray;
}

//-(NSString *)getQuestionImageURlFromQuestionData:(Quesiton *)aQuestion {
//    
//    
//    
//    
//}


@end
