//
//  Personas.h
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Image.h"
#import <JSONModel/JSONModel.h>
@protocol Personas @end
@interface Personas : JSONModel

@property(nonatomic,assign) NSInteger  personaID;
@property(nonatomic,strong) NSString * id_type;
@property(nonatomic,strong) NSString * title;
@property(nonatomic,strong) NSString * text;
@property(nonatomic,strong) NSString * social;
@property(nonatomic,assign) BOOL  max;
@property(nonatomic,assign) BOOL  min;
@property (nonatomic,strong) Image<Optional> *image;

@end
