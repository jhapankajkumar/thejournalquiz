//
//  YesNoImageTableViewCell.m
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "YesNoImageTableViewCell.h"
#import "Quesiton.h"
#import "Answers.h"
#import "Image.h"
#import <UIImageView+WebCache.h>


#define HEAD_LINE_FONT_SIZE             22
#define CAPTION_FONT_SIZE               14
#define QUESTION_FONT_SIZE              12



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
    Quesiton *question = (Quesiton*)aData;
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
    
    if (question.image && question.image.src) {
        totalHeight = THUMB_HEIGHT+1;
        // new implementation it will always remian open
    }
    totalHeight = totalHeight + ANSWER_THUMB_HEIGHT + 8 ;
    totalHeight += 8;
    return totalHeight;
}

- (void)createCellForData:(id)aData tableView:(UITableView *)aTableView indexPath:(NSIndexPath *)anIndexPath controller:(id)controller {
    
    [super createCellForData:aData tableView:aTableView indexPath:anIndexPath controller:controller];
    //self.contentView.frame = CGRectMake(0, self.contentView.frame.origin.y, aTableView.frame.size.width, self.contentView.frame.size.height);
    CGFloat screenWidth = aTableView.superview.frame.size.width;
    Quesiton *question = (Quesiton*)aData;
    self.tableView = aTableView;
    __weak __typeof(&*self)weakSelf = self;
    self.data = aData;
    self.indexPath = anIndexPath;
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
    
    if (question.image && question.image.src ) {
        self.questionImage.hidden = NO;
        self.questionImage.frame = CGRectMake(8, totalHeight, THUMB_WIDTH-8, THUMB_HEIGHT);
        // set the gradient
        totalHeight = THUMB_HEIGHT+1;
        NSString *imageURLString = [NSString stringWithFormat:@"%@?width=&%f&height=%f",question.image.src,THUMB_WIDTH,THUMB_HEIGHT];
        //Downloading Question image
        
        [self.questionImage sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         
                                         if (image &&  [image isKindOfClass:[UIImage class]]) {
                                             YesNoImageTableViewCell *localCell = (YesNoImageTableViewCell*)[weakSelf.tableView cellForRowAtIndexPath:anIndexPath];
                                             if (localCell && [localCell isKindOfClass:[YesNoImageTableViewCell class]]) {
                                                 [localCell.questionImage setImage:image];
                                                 //[localCell.questionImage setGradientBackgroundWithStartColor:[UIColor clearColor] endColor:RGBA(0, 0, 0, 0.9)];
                                             }
                                         }
                                         else
                                         {
                                             //Need to
                                         }
                                         
                                     }];
        
        totalHeight = totalHeight + 8 ;
        
    }
    else {
        self.questionImage.hidden = YES;
        //self.answerViewLeadingConstraints.constant -=133;
    }
    
    if (question.answer && question.answer.count) {
        
        // Iterate through the home related objects and fill the view
        for (int i= 0; i<question.answer.count;i++) {
            Answers *answer = [question.answer objectAtIndex:i];
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
    NSLog(@"height %f",totalHeight);
    
}

@end
