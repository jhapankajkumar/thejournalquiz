//
//  Quesiton.h
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Answers.h"
#import <JSONModel/JSONModel.h>

@protocol Question @end

@interface Question : JSONModel

@property (nonatomic,assign) NSInteger questionID;
@property (nonatomic,strong) NSString  *id_type;
@property (nonatomic,strong) NSString  *text;
@property (nonatomic,strong) NSMutableArray<Answers>*  answers;
@property (nonatomic,strong) Image <Optional>  *image;


@end
