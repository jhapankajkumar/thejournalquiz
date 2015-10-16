//
//  ViewController.m
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "ViewController.h"
#import "DataFetchManager.h"
#import "ResponseData.h"
#import "Question.h"
#import "GenericTableViewCell.h"
#import "UserAnswer.h"
#import "Personas.h"

@interface ViewController () {
    NSMutableArray *nibOrClassNameArray;
    NSMutableArray *dataItemArray;
}

@end

@implementation ViewController

#pragma mark - ViewLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetup];
    DataFetchManager *manager =     [[DataFetchManager  alloc]init];
    
    [manager getQuizDataFromServerWithCompletionBlock:^(ResponseData* responseData, BOOL success, NSError *error) {
        
        if (success) {
            self.quizData = responseData;
            [self setUpTableViewCellInformation];
            self.questionCount = self.quizData.questions.count;
        }
        else {
            
        }
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods


-(void)initialSetup {
    
    //registering tableview cells
    [_quizListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_quizListTableView registerNib:[UINib nibWithNibName:@"MultipleChoiceImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"MultipleChoiceImageTableViewCell"];
    [_quizListTableView registerNib:[UINib nibWithNibName:@"YesNoButtonTableViewCell" bundle:nil] forCellReuseIdentifier:@"YesNoButtonTableViewCell"];
    [_quizListTableView registerNib:[UINib nibWithNibName:@"YesNoImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"YesNoImageTableViewCell"];
    //[_quizListTableView registerNib:[UINib nibWithNibName:@"MultipleChoiceButtonTableViewCell" bundle:nil] forCellReuseIdentifier:@"MultipleChoiceButtonTableViewCell"];
    
    [_quizListTableView registerClass:NSClassFromString(@"MultipleChoiceButtonTableViewCell") forCellReuseIdentifier:@"MultipleChoiceButtonTableViewCell"];
    
    [_quizListTableView registerNib:[UINib nibWithNibName:@"PersonaCell" bundle:nil] forCellReuseIdentifier:@"PersonaCell"];
}

-(void)setUpTableViewCellInformation {
    
    dataItemArray = [NSMutableArray new];
    nibOrClassNameArray = [NSMutableArray new];
    
    for (Question *questions in self.quizData.questions){
        if (questions.answers.count==4 || questions.answers.count==3) {
            
            Answers *answer =(Answers *) [questions.answers objectAtIndex:0];
            if (answer.image) {
                //[nibOrClassNameArray addObject:@"MultipleChoiceImageTableViewCell"];
                //[dataItemArray addObject:questions];
            }
            else {
                [nibOrClassNameArray addObject:@"MultipleChoiceButtonTableViewCell"];
                [dataItemArray addObject:questions];
            }
        }
        else if (questions.answers.count == 2) {
            Answers *answer =(Answers *) [questions.answers objectAtIndex:0];
            if (answer.image) {
                //[nibOrClassNameArray addObject:@"YesNoImageTableViewCell"];
                //[dataItemArray addObject:questions];
            }
            else {
                [nibOrClassNameArray addObject:@"MultipleChoiceButtonTableViewCell"];
                [dataItemArray addObject:questions];
            }
        }
        else {
            NSLog(@"No Count %@",questions);
        }
        
       // [dataItemArray addObject:questions];
    }
    
    //Add Persona Cell
    
    [nibOrClassNameArray addObject:@"PersonaCell"];
    [dataItemArray addObject:self.quizData.personas.firstObject];
    
    
    self.answerDictionary = [[NSMutableDictionary alloc]init];
    self.scoreDictionary = [[NSMutableDictionary alloc]init];
    [self.quizListTableView reloadData];
}

-(void)answerSelectedFromCell:(GenericTableViewCell *)genericCell atIndePath:(NSIndexPath *)indexPath forQuestion:(Question *)aQuestion withAnswer:(Answers *)answer {
    
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
        
        //sort result
        NSArray *sortedArray = [values sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            if ([obj1 floatValue] > [obj2 floatValue])
                return NSOrderedDescending;
            else if ([obj1 floatValue] < [obj2 floatValue])
                return NSOrderedAscending;
            return NSOrderedSame;
        }];

        NSNumber *heightScorePersona = [sortedArray lastObject];
        NSInteger personaID = 0 ;
        
        for (NSNumber *number in self.scoreDictionary.allKeys) {
            if (heightScorePersona.integerValue == [[self.scoreDictionary objectForKey:number] integerValue]) {
                personaID = number.integerValue;
            }
        }
        for (Personas* persona in self.quizData.personas) {
            if (persona.personaID==personaID) {
                
                [dataItemArray removeLastObject];
                [dataItemArray addObject:persona];
                [self.quizListTableView beginUpdates];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.quizData.questions.count-1 inSection:0];
                [self.quizListTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [self.quizListTableView endUpdates];
            }
        }
    }
}

-(NSString *)getStringFromIntegerValue:(NSInteger)integerValue {
    NSString *keyString =  [NSString stringWithFormat:@"%ld",(long)integerValue];
    return keyString;
    
}


-(CGFloat )getDecimalValueFromString:(NSString *)score {
    return [score floatValue];
}

-(void)tryAgainQuiz:(UIButton *) sender {
    
    [self.answerDictionary removeAllObjects];
    [self.scoreDictionary removeAllObjects];
    [self.quizListTableView reloadData];
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
    //GoogleSearchResult *searchResult = [self.googleSearchResponse.responseData.results objectAtIndex:indexPath.row];
    
    GenericTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[nibOrClassNameArray objectAtIndex:indexPath.row]];
    [cell createCellForData:[dataItemArray objectAtIndex:indexPath.row] tableView:tableView indexPath:indexPath controller:self];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
//    /* Create custom view to display section header... */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 30)];
//    [label setFont:[UIFont boldSystemFontOfSize:18]];
//    NSString *string = self.quizData.title;
//    /* Section header is in 0th index... */
//    [label setText:string];
//    [view addSubview:label];
//    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
//    return view;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.quizData.title;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Class className = NSClassFromString([nibOrClassNameArray objectAtIndex:indexPath.row]);
    // Check if class name exists, if yes this means that Cell class has been created.
    if (className && [className respondsToSelector:@selector(rowHeightForData:tableView:indexPath:controller:)]) {
        return [className rowHeightForData:[dataItemArray objectAtIndex:indexPath.row] tableView:tableView indexPath:indexPath controller:self];
    }
    return 0;
}




@end
