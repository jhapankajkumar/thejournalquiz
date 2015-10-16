//
//  YesNoImageTableViewCell.m
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "YesNoImageTableViewCell.h"
#import "Question.h"
#import "Answers.h"
#import "Image.h"
#import <UIImageView+WebCache.h>
#import "Constant.h"
#import "ViewController.h"
#import "UserAnswer.h"


#define HEAD_LINE_FONT_SIZE             22
#define CAPTION_FONT_SIZE               14
#define QUESTION_FONT_SIZE              12
#define IMAGE_RESIZE_VALUE              CGSizeMake(130,105)



#define THUMB_WIDTH                 [UIScreen mainScreen].bounds.size.width
#define THUMB_HEIGHT                (THUMB_WIDTH) * 210/320

#define ANSWER_THUMB_WIDTH          150

#define ANSWER_THUMB_HEIGHT         125

@implementation YesNoImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (CGFloat)rowHeightForData:(id)aData tableView:(UITableView*)aTableView indexPath:(NSIndexPath *)anIndexPath controller:(id)controller {
    
    CGFloat screenWidth = aTableView.superview.frame.size.width;
    Question *question = (Question*)aData;
    // Init with base padding
    float totalHeight = 10;
    
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
    
//    if (question.image && question.image.src) {
//        totalHeight = THUMB_HEIGHT+1;
//        // new implementation it will always remian open
//    }
    totalHeight = totalHeight + 8 + ANSWER_THUMB_HEIGHT + 8 ;
    totalHeight += 20;
    return totalHeight;
}

- (void)createCellForData:(id)aData tableView:(UITableView *)aTableView indexPath:(NSIndexPath *)anIndexPath controller:(id)controller {
    
    [super createCellForData:aData tableView:aTableView indexPath:anIndexPath controller:controller];

    CGFloat screenWidth = aTableView.superview.frame.size.width;
    Question *question = (Question*)aData;
    self.tableView = aTableView;
    __weak __typeof(&*self)weakSelf = self;
    self.data = aData;
    self.indexPath = anIndexPath;
    
    homeViewController = (ViewController *)controller;
    
    
    CGFloat totalHeight = 8;
    CGSize maximumLabelSize = CGSizeMake(screenWidth - 20,FLT_MAX);
    CGSize expectedLabelSize;
    //    for (id subView in subViews) {
    //        if ([subView isKindOfClass:[UIButton class]]) {
    //            [subView removeFromSuperview];
    //        }
    //    }
    
    [self.headLine setFont:[UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]];
    
    //set Question headline
    CGRect rect =  [question.text boundingRectWithSize:maximumLabelSize
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{
                                                         NSFontAttributeName : [UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]
                                                         }
                                               context:nil];
    expectedLabelSize = rect.size;
    
    if (expectedLabelSize.height > 160) {
        self.headLine.frame = CGRectMake(8, totalHeight, maximumLabelSize.width, 160);
    }
    else {
        self.headLine.frame = CGRectMake(8, totalHeight, maximumLabelSize.width, expectedLabelSize.height);
    }
    self.headLine.text = question.text;
    totalHeight = totalHeight + expectedLabelSize.height;
    totalHeight = totalHeight + 8;
    
//    if (question.image && question.image.src ) {
//        self.questionImage.hidden = NO;
//        self.questionImage.frame = CGRectMake(8, totalHeight, THUMB_WIDTH-8, THUMB_HEIGHT);
//        // set the gradient
//        totalHeight = THUMB_HEIGHT+1;
//        NSString *imageURLString = [NSString stringWithFormat:@"%@?width=&%f&height=%f",question.image.src,THUMB_WIDTH,THUMB_HEIGHT];
//        //Downloading Question image
//        
//        [self.questionImage sd_setImageWithURL:[NSURL URLWithString:imageURLString]
//                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
//                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                         
//                                         if (image &&  [image isKindOfClass:[UIImage class]]) {
//                                             YesNoImageTableViewCell *localCell = (YesNoImageTableViewCell*)[weakSelf.tableView cellForRowAtIndexPath:anIndexPath];
//                                             if (localCell && [localCell isKindOfClass:[YesNoImageTableViewCell class]]) {
//                                                 [localCell.questionImage setImage:image];
//                                                 //[localCell.questionImage setGradientBackgroundWithStartColor:[UIColor clearColor] endColor:RGBA(0, 0, 0, 0.9)];
//                                             }
//                                         }
//                                         else
//                                         {
//                                             //Need to
//                                         }
//                                         
//                                     }];
//        
//        totalHeight = totalHeight + 8 ;
//        
//    }
//    else {
//        self.questionImage.hidden = YES;
//        //self.answerViewLeadingConstraints.constant -=133;
//    }
    
    if (question.answers && question.answers.count) {
        
        // Iterate through the home related objects and fill the view
        for (int i= 0; i<question.answers.count;i++) {
            Answers *answer = [question.answers objectAtIndex:i];
            switch (i) {
                case 0:
                {
                    self.choiceOneView.frame = CGRectMake(8, totalHeight, ANSWER_THUMB_WIDTH, ANSWER_THUMB_HEIGHT);
                    NSString *imageURLString = answer.image.src;
                    //Downloading Question image
                    [self.choiceOneImage sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                                           placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                      
                                                      if (image &&  [image isKindOfClass:[UIImage class]]) {
                                                          YesNoImageTableViewCell *localCell = (YesNoImageTableViewCell*)[weakSelf.tableView cellForRowAtIndexPath:anIndexPath];
                                                          if (localCell && [localCell isKindOfClass:[YesNoImageTableViewCell class]]) {
                                                              [localCell.choiceOneImage setImage:image];
                                                              //[localCell.questionImage setGradientBackgroundWithStartColor:[UIColor clearColor] endColor:RGBA(0, 0, 0, 0.9)];
                                                          }
                                                      }
                                                      else
                                                      {
                                                          //Need to
                                                      }
                                                      
                                                  }];
                    
                }
                    break;
                case 1:
                {
                    self.choiceTwoView.frame = CGRectMake(8+ ANSWER_THUMB_WIDTH + 8, totalHeight, ANSWER_THUMB_WIDTH, ANSWER_THUMB_HEIGHT);
                    totalHeight = totalHeight + ANSWER_THUMB_HEIGHT + 8 ;
                    NSString *imageURLString = answer.image.src;
                    //Downloading Question image
                    
                    [self.choiceTwoImage sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                                           placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                      
                                                      if (image &&  [image isKindOfClass:[UIImage class]]) {
                                                          YesNoImageTableViewCell *localCell = (YesNoImageTableViewCell*)[weakSelf.tableView cellForRowAtIndexPath:anIndexPath];
                                                          if (localCell && [localCell isKindOfClass:[YesNoImageTableViewCell class]]) {
                                                              [localCell.choiceTwoImage setImage:image];
                                                              //[localCell.questionImage setGradientBackgroundWithStartColor:[UIColor clearColor] endColor:RGBA(0, 0, 0, 0.9)];
                                                          }
                                                      }
                                                      else
                                                      {
                                                          //Need to
                                                      }
                                                      
                                                  }];
                    
                }
                    
                default:
                    break;
            }
            // Increase totalHeight by HEIGHT_OF_RELATED_VIEW
            totalHeight = totalHeight + 8;
        }
    }
    
    
    UITapGestureRecognizer *tapGestureChoiceOne = [[UITapGestureRecognizer alloc]init];
    [tapGestureChoiceOne addTarget:self action:@selector(choiceOneSelected:)];
    [_choiceOneView addGestureRecognizer:tapGestureChoiceOne];
    
    UITapGestureRecognizer *tapGestureChoiceTwo = [[UITapGestureRecognizer alloc]init];
    [tapGestureChoiceTwo addTarget:self action:@selector(choiceTwoSelected:)];
    [_choiceTwoView addGestureRecognizer:tapGestureChoiceTwo];
    
    _choiceOneView.backgroundColor = RGB(249, 249, 249);
    _choiceTwoView.backgroundColor = RGB(249, 249, 249);

    
    for (NSString  *questionID in homeViewController.answerDictionary.allKeys) {
        if ([questionID integerValue] == question.questionID) {
            UserAnswer *userAnswer = [homeViewController.answerDictionary objectForKey:questionID];
            for (int i = 0; i<question.answers.count; i++) {
                Answers *answer  = [question.answers objectAtIndex:i];
                if (userAnswer.answerId == answer.answerId) {
                    switch (i) {
                        case 0:
                        {
                            _choiceOneView.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
                            _choiceTwoView.backgroundColor = RGB(249, 249, 249);
                            
                        }
                            break;
                        case 1:
                        {
                            _choiceTwoView.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
                            _choiceOneView.backgroundColor = RGB(249, 249, 249);
                        }
                            break;
                            
                        default:
                            break;
                    }
                    break;
                }
                
            }
            //self
        }
    }
    
}

-(void)choiceOneSelected:(UITapGestureRecognizer *)gesture {
    Question *question = (Question *)self.data;
    if (homeViewController.answerDictionary.allKeys.count!=homeViewController.questionCount) {
        UIView *choiceOneView =(UIView *) gesture.view;
        choiceOneView.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
        _choiceTwoView.backgroundColor = RGB(249, 249, 249);
        [(ViewController*)homeViewController answerSelectedFromCell:self atIndePath:self.indexPath forQuestion:question withAnswer:[question.answers firstObject]];
    }
}

-(void)choiceTwoSelected:(UITapGestureRecognizer *)gesture {
    
    if (homeViewController.answerDictionary.allKeys.count!=homeViewController.questionCount) {
        UIView *choiceTwoView =(UIView *) gesture.view;
        choiceTwoView.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
        _choiceOneView.backgroundColor = RGB(249, 249, 249);
        Question *question = (Question *)self.data;
        [(ViewController*)homeViewController answerSelectedFromCell:self atIndePath:self.indexPath forQuestion:question withAnswer:[question.answers objectAtIndex:1]];
    }
    
}


@end
