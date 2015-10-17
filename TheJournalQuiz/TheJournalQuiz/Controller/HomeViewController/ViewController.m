//
//  ViewController.m
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "ViewController.h"
#import "DataFetchManager.h"
#import "QuizData.h"
#import "Question.h"
#import "GenericTableViewCell.h"
#import "UserAnswer.h"
#import "Personas.h"
#import "Constant.h"
@interface ViewController () {
    NSMutableArray *nibOrClassNameArray;
    NSMutableArray *dataItemArray;
}

@end

@implementation ViewController

#pragma mark - ViewLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Register table view cell class
    [self initialSetup];
    
    [self getQuizdataFromServer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.quizListTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
-(void)initialSetup {
    //registering tableview cells
    //[_quizListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.quizListTableView.hidden = true;
    [_quizListTableView registerClass:NSClassFromString(@"MultipleChoiceImageTableViewCell") forCellReuseIdentifier:@"MultipleChoiceImageTableViewCell"];
    [_quizListTableView registerClass:NSClassFromString(@"MultipleChoiceButtonTableViewCell") forCellReuseIdentifier:@"MultipleChoiceButtonTableViewCell"];
    [_quizListTableView registerClass:NSClassFromString(@"PersonaCell") forCellReuseIdentifier:@"PersonaCell"];
}

-(void)setUpTableViewCellInformation {
    
    dataItemArray = [NSMutableArray new];
    nibOrClassNameArray = [NSMutableArray new];
    
    //Adding cell data with cell class name
    for (Question *questions in self.quizData.questions){
        Answers *answer =(Answers *) [questions.answers objectAtIndex:0];
        if (answer.image) {
            [nibOrClassNameArray addObject:@"MultipleChoiceImageTableViewCell"];
        }
        else {
            [nibOrClassNameArray addObject:@"MultipleChoiceButtonTableViewCell"];
        }
        [dataItemArray addObject:questions];
    }
    
    //Add Persona Cell
    [nibOrClassNameArray addObject:@"PersonaCell"];
    [dataItemArray addObject:self.quizData.personas.firstObject];
    
    //Initialize answer dictionary
    self.answerDictionary = [[NSMutableDictionary alloc]init];
    self.scoreDictionary = [[NSMutableDictionary alloc]init];
    [self.quizListTableView reloadData];
}


-(void)getQuizdataFromServer {
    DataFetchManager *manager =     [[DataFetchManager  alloc]init];
    //get qize data from server
    [manager getQuizDataFromServerWithCompletionBlock:^(QuizData* responseData, BOOL success, NSError *error) {
        if (success) {
            self.quizData = responseData;
            [self setUpTableViewCellInformation];
            self.questionCount = self.quizData.questions.count;
            self.quizListTableView.hidden  = false;
            self.loadingIndicator.hidden = true;
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Quiz" message:@"Oops something went wrong, please check you internet connection and try later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            self.loadingIndicator.hidden = true;
        }
    }];
}

-(void)selectedAnswer:(Answers *)answer  atIndePath:(NSIndexPath *)indexPath forQuestion:(Question *)aQuestion {
    
    @try {
        //get User answer if any saved .
        UserAnswer *userAnswer = [self.answerDictionary objectForKey:[self getStringFromIntegerValue:aQuestion.questionID]];
        if (!userAnswer) {
            userAnswer = [[UserAnswer alloc]init];
        }
        //set details
        userAnswer.indexPath = indexPath;
        userAnswer.answerId = answer.answerId;
        userAnswer.score = answer.score;
        userAnswer.personaIDs = answer.persona_ids;
        userAnswer.questionId = aQuestion.questionID;
        
        //save user answer detail to dictionary
        [self.answerDictionary setValue:userAnswer forKey:[self getStringFromIntegerValue:aQuestion.questionID]];
        
        NSLog(@"User Answer %@",self.answerDictionary);
        
        //If All answer selected
        if (self.answerDictionary.allKeys.count>=self.quizData.questions.count) {
            NSLog(@"All Question Answred");
            for (UserAnswer *userAnswer in self.answerDictionary.allValues){
                
                //get question
                Question *question = [self getQuestionFromQuestionID:userAnswer.questionId];
                
                //get Answer
                Answers *answer = [self getAnswerFromAnswerArray:question.answers usignAnswerID:userAnswer.answerId];
                
                //get current answer score
                NSNumber *score =  [NSNumber numberWithDouble:answer.score];
                for (int i = 0; i<answer.persona_ids.count; i++) {
                    //get persona ID
                    NSInteger personaID = [[answer.persona_ids objectAtIndex:i] integerValue];
                    //check if previous score is available for current persona Id
                    NSNumber *previousScore = [self.scoreDictionary valueForKey:[self getStringFromIntegerValue:personaID]];
                    
                    //If available
                    if (previousScore) {
                        
                        //Add new and previous score
                        NSNumber *newScore = [NSNumber numberWithDouble:score.doubleValue+previousScore.doubleValue];
                        
                        //save to dictionary
                        [self.scoreDictionary setValue:newScore forKey:[self getStringFromIntegerValue:personaID]];
                    }
                    // if new value
                    else {
                        [self.scoreDictionary setValue:score forKey:[self getStringFromIntegerValue:personaID]];
                    }
                }
            }
            NSArray* values = [self.scoreDictionary allValues];
            
            //sort result on score
            NSArray *sortedArray = [values sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                if ([obj1 floatValue] > [obj2 floatValue])
                    return NSOrderedDescending;
                else if ([obj1 floatValue] < [obj2 floatValue])
                    return NSOrderedAscending;
                return NSOrderedSame;
            }];
            
            //get personar highest score
            NSNumber *heightScorePersona = [sortedArray lastObject];
            NSInteger personaID = 0 ;
            
            //getting persona ID which has highest score
            for (NSNumber *number in self.scoreDictionary.allKeys) {
                if (heightScorePersona.integerValue == [[self.scoreDictionary objectForKey:number] integerValue]) {
                    personaID = number.integerValue;
                }
            }
            
            //get persona detail with highest score
            for (Personas* persona in self.quizData.personas) {
                if (persona.personaID==personaID) {
                    [dataItemArray removeLastObject];
                    [dataItemArray addObject:persona];
                    
                    //Update cell with new personal information
                    [self.quizListTableView beginUpdates];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.quizData.questions.count inSection:0];
                    [self.quizListTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    [self.quizListTableView endUpdates];
                }
            }
        }
    }
    @catch (NSException *exception) {
        
    }
}

-(NSString *)getStringFromIntegerValue:(NSInteger)integerValue {
    NSString *keyString =  [NSString stringWithFormat:@"%ld",(long)integerValue];
    return keyString;
    
}

//Method to restart quiz again
-(void)retryQuizAgain:(UIButton *) sender {
    
    //remove all values from dictionary
    [self.answerDictionary removeAllObjects];
    [self.scoreDictionary removeAllObjects];
    
    //scroll to top
    [self.quizListTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    //reload table data
    [self.quizListTableView reloadData];
}

//Mehod to share the result
-(void)shareResultWithData:(Personas *)resultData {
    
    NSArray *objectsToShare = @[resultData.social,resultData.image.src];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    NSArray *excludedActivities = @[
                                    UIActivityTypePostToWeibo,
                                    UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
                                    UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
    controller.excludedActivityTypes = excludedActivities;
    
    [controller setCompletionHandler:^(NSString *activityType, BOOL completed)
     {
         NSMutableString *messageString = [[NSMutableString alloc]initWithCapacity:0];
         if ([activityType isEqualToString:@"com.apple.UIKit.activity.SaveToCameraRoll"])
         {
             [messageString appendString:@"Image Saved"];
         }
         else if ([activityType isEqualToString:@"com.apple.UIKit.activity.PostToTwitter"])
         {
             [messageString appendString:@"Image posted to twitter"];
         }
         else if ([activityType isEqualToString:@"com.apple.UIKit.activity.Mail"])
         {
             [messageString appendString:@"Image sent by email"];
         }
         else if ([activityType isEqualToString:@"com.apple.UIKit.activity.CopyToPasteboard"])
         {
             [messageString appendString:@"Image copied to pasteboard"];
         }
         else if ([activityType isEqualToString:@"com.apple.UIKit.activity.AssignToContact"])
         {
             [messageString appendString:@"Image assigned to contact"];
         }
         else if ([activityType isEqualToString:@"com.apple.UIKit.activity.Message"])
         {
             [messageString appendString:@"Image sent via message"];
         }
         else if ([activityType isEqualToString:@"com.apple.UIKit.activity.Print"])
         {
             [messageString appendString:@"Image sent to printer"];
         }
         
         if (completed == TRUE)
         {
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success!" message:messageString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert show];
             
         }
     }];
    // Present the controller
    [self presentViewController:controller animated:YES completion:nil];
    
    
}


-(Question *)getQuestionFromQuestionID:(NSInteger)aID  {
    NSArray *questionArray = [self.quizData.questions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"questionID = %d",aID]];
    return questionArray.firstObject;
}

-(Answers *)getAnswerFromAnswerArray:(NSMutableArray *)aAnswerArray usignAnswerID:(NSInteger)aID  {
    NSArray *answerArray = [aAnswerArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"answerId = %d",aID]];
    return answerArray.firstObject;
}


#pragma mark - UITableView Data Source -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nibOrClassNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        GenericTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[nibOrClassNameArray objectAtIndex:indexPath.row]];
        [cell createCellForData:[dataItemArray objectAtIndex:indexPath.row] tableView:tableView indexPath:indexPath controller:self];
        return cell;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@",exception.description);
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 20)];
    [label setFont:[UIFont boldSystemFontOfSize:18]];
    NSString *string = self.quizData.title;
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:CHOICE_LABEL_DEFAULT_COLOR]; //your background color...
    return view;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//
//    return self.quizData.title;
//}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    @try {
        Class className = NSClassFromString([nibOrClassNameArray objectAtIndex:indexPath.row]);
        // Check if class name exists, if yes this means that Cell class has been created.
        if (className && [className respondsToSelector:@selector(rowHeightForData:tableView:indexPath:controller:)]) {
            return [className rowHeightForData:[dataItemArray objectAtIndex:indexPath.row] tableView:tableView indexPath:indexPath controller:self];
        }
        return 0;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@",exception.description);
    }
}

@end
