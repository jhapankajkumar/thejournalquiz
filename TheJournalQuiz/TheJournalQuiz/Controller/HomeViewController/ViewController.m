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
#import "Quesiton.h"
#import "GenericTableViewCell.h"


@interface ViewController () {
    NSMutableArray *nibOrClassNameArray;
    NSMutableArray *dataItemArray;
    ResponseData *quizData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetup];
    DataFetchManager *manager =     [[DataFetchManager  alloc]init];
    
    [manager getQuizDataFromServerWithCompletionBlock:^(ResponseData* responseData, BOOL success, NSError *error) {
        
        if (success) {
            quizData = responseData;
            [self setUpTableViewCellInformation];
        }
        else {
            
        }
    }];

    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)initialSetup {
    
    [_quizListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_quizListTableView registerNib:[UINib nibWithNibName:@"MultipleChoiceImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"MultipleChoiceImageTableViewCell"];
    [_quizListTableView registerNib:[UINib nibWithNibName:@"YesNoButtonTableViewCell" bundle:nil] forCellReuseIdentifier:@"YesNoButtonTableViewCell"];
    [_quizListTableView registerNib:[UINib nibWithNibName:@"YesNoImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"YesNoImageTableViewCell"];
    [_quizListTableView registerNib:[UINib nibWithNibName:@"MultipleChoiceButtonTableViewCell" bundle:nil] forCellReuseIdentifier:@"MultipleChoiceButtonTableViewCell"];
}


-(void)setUpTableViewCellInformation {
    
    dataItemArray = [NSMutableArray new];
    nibOrClassNameArray = [NSMutableArray new];
    
    for (Quesiton *questions in quizData.questions){
        if (questions.answer.count==4 || questions.answer.count==3) {
            
            Answers *answer =(Answers *) [questions.answer objectAtIndex:0];
            if (answer.image) {
                [nibOrClassNameArray addObject:@"MultipleChoiceImageTableViewCell"];
            }
            else {
                [nibOrClassNameArray addObject:@"MultipleChoiceButtonTableViewCell"];
            }
        }
        else if (questions.answer.count == 2) {
            Answers *answer =(Answers *) [questions.answer objectAtIndex:0];
            if (answer.image) {
                [nibOrClassNameArray addObject:@"YesNoImageTableViewCell"];
            }
            else {
                [nibOrClassNameArray addObject:@"YesNoButtonTableViewCell"];
            }
        }
        else {
            NSLog(@"No Count %@",questions);
        }
        
        [dataItemArray addObject:questions];
    }
    
    [self.quizListTableView reloadData];
    
//        // Check if Sponsered or photo story is present then do not add comment cell
//        if (!(_newsItem.Sponsored && _newsItem.Sponsored.length)) {
//            [_newsItemArray addObject:_newsItem];
//            [_nibOrClassNamesArray addObject:@"NewsDetailCommentCell"];
//        }
//        
//        // Check and add next story
//        if (_newsNextItem) {
//            [_newsItemArray addObject:_newsNextItem];
//            [_nibOrClassNamesArray addObject:@"NewsDetailNextStoryCell"];
//        }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Methods -

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
//    GoogleSearchResult *searchResult = [self.googleSearchResponse.responseData.results objectAtIndex:indexPath.row];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:searchResult.url]];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Class className = NSClassFromString([nibOrClassNameArray objectAtIndex:indexPath.row]);
    // Check if class name exists, if yes this means that Cell class has been created.
    if (className && [className respondsToSelector:@selector(rowHeightForData:tableView:indexPath:controller:)]) {
        return [className rowHeightForData:[dataItemArray objectAtIndex:indexPath.row] tableView:tableView indexPath:indexPath controller:self];
    }
    /*
     GenericTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[_nibOrClassNamesArray objectAtIndex:indexPath.row]];
     
     if ([cell respondsToSelector:@selector(rowHeightForData:tableView:indexPath:controller:)]) {
     return [cell rowHeightForData:[_newsItemArray objectAtIndex:indexPath.row] tableView:tableView indexPath:indexPath controller:self];
     }
     */
    return 0;
}


@end
