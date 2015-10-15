//
//  YesNoButtonTableViewCell.m
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "YesNoButtonTableViewCell.h"
#import "Question.h"
#import "Answers.h"
#import "Image.h"
#import <UIImageView+WebCache.h>
#import "Constant.h"
#import "UserAnswer.h"
#import "ViewController.h"

#define HEAD_LINE_FONT_SIZE             22
#define CAPTION_FONT_SIZE               14
#define QUESTION_FONT_SIZE              12



#define THUMB_WIDTH                 [UIScreen mainScreen].bounds.size.width
#define THUMB_HEIGHT                (THUMB_WIDTH) * 180/320
@implementation YesNoButtonTableViewCell

- (void)awakeFromNib {
    _choiceOne.numberOfLines = 0;
    _choiceOne.lineBreakMode =  NSLineBreakByWordWrapping;
    [_choiceOne setFont:[UIFont systemFontOfSize:QUESTION_FONT_SIZE]];
    _choiceOne.layer.cornerRadius = 5.0;
    _choiceOne.userInteractionEnabled = YES;
    _choiceOne.numberOfLines = 0;
    
    _choiceTwo.numberOfLines = 0;
    _choiceTwo.lineBreakMode =  NSLineBreakByWordWrapping;
    [_choiceTwo setFont:[UIFont systemFontOfSize:QUESTION_FONT_SIZE]];
    _choiceTwo.layer.cornerRadius = 5.0;
    _choiceTwo.userInteractionEnabled = YES;
    _choiceTwo.numberOfLines = 0;
    
    self.headLine.numberOfLines = 0;
    self.headLine.lineBreakMode = NSLineBreakByWordWrapping;
    [self.headLine setFont:[UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]];
}

+ (CGFloat)rowHeightForData:(id)aData tableView:(UITableView*)aTableView indexPath:(NSIndexPath *)anIndexPath controller:(id)controller {
    
    CGFloat screenWidth = aTableView.superview.frame.size.width;
    Question *question = (Question*)aData;
    // Init with base padding
    float totalHeight = 0;
    
    CGSize maximumLabelSize = CGSizeMake(screenWidth-20,FLT_MAX);
    CGSize expectedLabelSize;
    
    CGRect rect =  [question.text boundingRectWithSize:maximumLabelSize
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{
                                                         NSFontAttributeName : [UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]
                                                         }
                                               context:nil];
    expectedLabelSize = rect.size;
    
    // Update the Height
    totalHeight = totalHeight + expectedLabelSize.height;
    // Add Padding
    totalHeight += 10;
    
    if (question.image && question.image.src) {
        totalHeight = THUMB_HEIGHT+1;
        // new implementation it will always remian open
    }
    
    for (Answers *answer in question.answer ){
        CGRect rect =  [answer.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:QUESTION_FONT_SIZE] } context:nil];
        expectedLabelSize = rect.size;
        
        if (expectedLabelSize.height<70) {
            expectedLabelSize.height = 70;
        }
        totalHeight = totalHeight + expectedLabelSize.height;
        totalHeight += 10;
    }
    
    return totalHeight+30+10;
}

- (void)createCellForData:(id)aData tableView:(UITableView *)aTableView indexPath:(NSIndexPath *)anIndexPath controller:(id)controller {
    
    [super createCellForData:aData tableView:aTableView indexPath:anIndexPath controller:controller];
    self.contentView.frame = CGRectMake(0, self.contentView.frame.origin.y, aTableView.frame.size.width, self.contentView.frame.size.height);
    
    //Initial Data Setup
    CGFloat screenWidth = aTableView.superview.frame.size.width;
    Question *question = (Question*)aData;
    homeViewController = (ViewController *)controller;
    self.tableView = aTableView;
    __weak __typeof(&*self)weakSelf = self;
    self.data = aData;
    self.indexPath = anIndexPath;
    
    
    //label Setup
    CGFloat totalHeight = 10;
    CGSize maximumLabelSize = CGSizeMake(screenWidth - 20,FLT_MAX);
    CGSize expectedLabelSize;
    
    //set Question headLine
    [self.headLine setFont:[UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]];
    CGRect rect =  [question.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]} context:nil];
    expectedLabelSize = rect.size;
    if (expectedLabelSize.height > 160) {
        self.headLine.frame = CGRectMake(10, totalHeight, maximumLabelSize.width, 160);
    }
    else {
        self.headLine.frame = CGRectMake(10, totalHeight, maximumLabelSize.width, expectedLabelSize.height);
    }
    self.headLine.text = question.text;
    
    
    //Increase Total Height
    totalHeight = totalHeight + expectedLabelSize.height;
    //Add Extra Spacing
    totalHeight = totalHeight + 8;
    
    //Question Image Setupd
    if (question.image && question.image.src ) {
        self.questionImage.hidden = NO;
        self.questionImage.frame = CGRectMake(0, totalHeight, screenWidth, THUMB_HEIGHT);
        totalHeight = THUMB_HEIGHT+1;
        NSString *imageURLString = question.image.src;
        //Downloading Question image
        [self.questionImage sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         if (image &&  [image isKindOfClass:[UIImage class]]) {
                                             YesNoButtonTableViewCell *localCell = (YesNoButtonTableViewCell*)[weakSelf.tableView cellForRowAtIndexPath:anIndexPath];
                                             if (localCell && [localCell isKindOfClass:[YesNoButtonTableViewCell class]]) {
                                                 [localCell.questionImage setImage:image];
                                                 //[localCell.questionImage setGradientBackgroundWithStartColor:[UIColor clearColor] endColor:RGBA(0, 0, 0, 0.9)];
                                             }
                                         }
                                         else
                                         {
                                             //Need to
                                         }
                                         
                                     }];
        //add extra space
        totalHeight = totalHeight + 8 ;
        
        if (question.answer && question.answer.count) {
            // Iterate through the home related objects and fill the view
            for (int i= 0; i<question.answer.count;i++) {
                Answers *answer = [question.answer objectAtIndex:i];
                
                //set Question headline
                CGRect rect =  [question.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:QUESTION_FONT_SIZE] } context:nil];
                expectedLabelSize = rect.size;
                
                if (expectedLabelSize.height<70) {
                    expectedLabelSize.height = 70;
                }
                switch (i) {
                    case 0:
                    {
                        _choiceOne.frame = CGRectMake(8, totalHeight, expectedLabelSize.width, expectedLabelSize.height);
                        totalHeight = totalHeight + expectedLabelSize.height;
                        totalHeight += 8;
                        _choiceOne.text = answer.text;
                        
                        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
                        [tapGesture addTarget:self action:@selector(choiceOneSelected:)];
                        [_choiceOne addGestureRecognizer:tapGesture];
                        
                    }
                        break;
                    case 1:
                    {
                        _choiceTwo.frame = CGRectMake(8, totalHeight, expectedLabelSize.width, expectedLabelSize.height);
                        totalHeight = totalHeight + expectedLabelSize.height;
                        totalHeight += 8;
                        _choiceTwo.text = answer.text;
                        
                        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
                        [tapGesture addTarget:self action:@selector(choiceTwoSelected:)];
                        [_choiceTwo addGestureRecognizer:tapGesture];
                    }
                        break;
                        
                    default:
                        break;
                }
                
                
                
                // Increase totalHeight by HEIGHT_OF_RELATED_VIEW
                totalHeight = totalHeight + 8;
            }
        }
    }
    

        _choiceOne.backgroundColor = RGB(249, 249, 249);
    _choiceTwo.backgroundColor = RGB(249, 249, 249);
    
    for (NSString  *questionID in homeViewController.answerDictionary.allKeys) {
        if ([questionID integerValue] == question.questionID) {
            UserAnswer *userAnswer = [homeViewController.answerDictionary objectForKey:questionID];
            for (int i = 0; i<question.answer.count; i++) {
                Answers *answer  = [question.answer objectAtIndex:i];
                if (userAnswer.answerId == answer.answerId) {
                    switch (i) {
                        case 0:
                        {
                            _choiceOne.backgroundColor = [UIColor greenColor];
                            _choiceTwo.backgroundColor = RGB(249, 249, 249);
                        }
                            break;
                        case 1:
                        {
                            _choiceTwo.backgroundColor = [UIColor greenColor];
                            _choiceOne.backgroundColor = RGB(249, 249, 249);
                        }
                            break;
                        default:
                            break;
                    }
                    break;
                }
            }
        }
    }
    
    UITapGestureRecognizer *tapGestureChoiceOne = [[UITapGestureRecognizer alloc]init];
    [tapGestureChoiceOne addTarget:self action:@selector(choiceOneSelected:)];
    [_choiceOne addGestureRecognizer:tapGestureChoiceOne];
    
    UITapGestureRecognizer *tapGestureChoiceTwo = [[UITapGestureRecognizer alloc]init];
    [tapGestureChoiceTwo addTarget:self action:@selector(choiceTwoSelected:)];
    [_choiceTwo addGestureRecognizer:tapGestureChoiceTwo];
    
}


-(void)choiceOneSelected:(UITapGestureRecognizer *)gesture {
    Question *question = (Question *)self.data;
    if (homeViewController.answerDictionary.allKeys.count!=homeViewController.questionCount) {
        UILabel *choiceOneLabel =(UILabel *) gesture.view;
        choiceOneLabel.backgroundColor = [UIColor greenColor];
        _choiceTwo.backgroundColor = RGB(249, 249, 249);
        [(ViewController*)homeViewController answerSelectedFromCell:self atIndePath:self.indexPath forQuestion:question withAnswer:[question.answer firstObject]];
    }
}

-(void)choiceTwoSelected:(UITapGestureRecognizer *)gesture {
    
    if (homeViewController.answerDictionary.allKeys.count!=homeViewController.questionCount) {
        UILabel *choiceOneLabel =(UILabel *) gesture.view;
        choiceOneLabel.backgroundColor = [UIColor greenColor];
        _choiceOne.backgroundColor = RGB(249, 249, 249);
        Question *question = (Question *)self.data;
        [(ViewController*)homeViewController answerSelectedFromCell:self atIndePath:self.indexPath forQuestion:question withAnswer:[question.answer objectAtIndex:1]];
    }
}

@end
