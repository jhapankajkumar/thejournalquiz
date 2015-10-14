//
//  Answers.h
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Image.h"

@interface Answers : NSObject

@property(nonatomic,assign) NSInteger  answerId;
@property(nonatomic,strong) NSString * id_type;
@property(nonatomic,strong) NSString * text;
@property(nonatomic,strong) NSString * version;
@property(nonatomic,assign) BOOL  correct;
@property(nonatomic,strong) NSNumber * score;
@property(nonatomic,strong) NSMutableArray * persona_ids;
@property (nonatomic,strong) Image *image;

@end
