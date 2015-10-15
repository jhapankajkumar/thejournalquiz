//
//  ViewController.h
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResponseData;
@class GenericTableViewCell;
@class Quesiton;
@class Answers;
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *quizListTableView;
@property (nonatomic,strong) NSMutableDictionary *answerDictionary;
@property (nonatomic,strong) NSMutableDictionary *scoreDictionary;
@property (nonatomic,strong) ResponseData *quizData;

@property (nonatomic) NSInteger questionCount;

-(void)answerSelectedFromCell:(GenericTableViewCell *)genericCell atIndePath:(NSIndexPath *)indexPath forQuestion:(Quesiton *)aQuestion withAnswer:(Answers *)answer;

@end

