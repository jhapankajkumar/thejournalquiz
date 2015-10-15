//
//  UserAnswer.h
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAnswer : NSObject

@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic) NSInteger questionId;
@property (nonatomic) NSInteger answerId;
@property (nonatomic) double score;
@property (nonatomic) NSMutableArray *personaIDs;
@property (nonatomic) BOOL allQuestionAnswered;

@end
