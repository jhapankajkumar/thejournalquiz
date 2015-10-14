//
//  ResponseData.h
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseData : NSObject

@property (nonatomic,assign) NSInteger responseID;
@property (nonatomic,strong) NSString * id_type;
@property (nonatomic,strong) NSString * type;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * created;
@property (nonatomic,strong) NSString * updated;
@property (nonatomic,strong) NSString * author;
@property (nonatomic,strong) NSMutableArray * personas;
@property (nonatomic,strong) NSMutableArray * questions;

@end
