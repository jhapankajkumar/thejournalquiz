//
//  ViewController.h
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QuizData;
@class GenericTableViewCell;
@class Question;
@class Answers;
@class Personas;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *quizListTableView;
@property (nonatomic,strong) NSMutableDictionary *answerDictionary;
@property (nonatomic,strong) NSMutableDictionary *scoreDictionary;
@property (nonatomic,strong) QuizData *quizData;

@property (nonatomic) NSInteger questionCount;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;


-(void)selectedAnswer:(Answers *)answer  atIndePath:(NSIndexPath *)indexPath forQuestion:(Question *)aQuestion;
//Method to retry quiz
-(void)retryQuizAgain:(UIButton *) sender ;

//Method to share quize result data
-(void)shareResultWithData:(Personas *)resultData;
@end

