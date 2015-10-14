//
//  Image.h
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject
@property(nonatomic,assign) NSInteger imageId;
@property(nonatomic,strong) NSString * object_id;
@property(nonatomic,strong) NSString * object_type;
@property(nonatomic,strong) NSString * src;
@property(nonatomic,strong) NSString * version;

@end
