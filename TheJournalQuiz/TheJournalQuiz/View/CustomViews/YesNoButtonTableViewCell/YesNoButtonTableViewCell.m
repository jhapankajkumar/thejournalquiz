//
//  YesNoButtonTableViewCell.m
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "YesNoButtonTableViewCell.h"
#import "Quesiton.h"
#import "Answers.h"
#import "Image.h"
#import <UIImageView+WebCache.h>


#define HEAD_LINE_FONT_SIZE             22
#define CAPTION_FONT_SIZE               14
#define QUESTION_FONT_SIZE              12



#define THUMB_WIDTH                 [UIScreen mainScreen].bounds.size.width
#define THUMB_HEIGHT                (THUMB_WIDTH) * 180/320
@implementation YesNoButtonTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)rowHeightForData:(id)aData tableView:(UITableView*)aTableView indexPath:(NSIndexPath *)anIndexPath controller:(id)controller {
    
    CGFloat screenWidth = aTableView.superview.frame.size.width;
    Quesiton *question = (Quesiton*)aData;
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
    CGFloat screenWidth = aTableView.superview.frame.size.width;
    Quesiton *question = (Quesiton*)aData;
    self.tableView = aTableView;
    __weak __typeof(&*self)weakSelf = self;
    self.data = aData;
    self.indexPath = anIndexPath;
    CGFloat totalHeight = 10;
    CGSize maximumLabelSize = CGSizeMake(screenWidth - 20,FLT_MAX);
    CGSize expectedLabelSize;
    NSArray *subViews = self.contentView.subviews;
    for (id subView in subViews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [subView removeFromSuperview];
        }
    }
    
    [self.headLine setFont:[UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]];
    
    //set Question headLine
    CGRect rect =  [question.text boundingRectWithSize:maximumLabelSize
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{
                                                         NSFontAttributeName : [UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]
                                                         }
                                               context:nil];
    expectedLabelSize = rect.size;
    
    if (expectedLabelSize.height > 160) {
        self.headLine.frame = CGRectMake(10, totalHeight, maximumLabelSize.width, 160);
    }
    else {
        self.headLine.frame = CGRectMake(10, totalHeight, maximumLabelSize.width, expectedLabelSize.height);
    }
    self.headLine.text = question.text;
    totalHeight = totalHeight + expectedLabelSize.height;
    totalHeight = totalHeight + 8;
    
    if (question.image && question.image.src ) {
        self.questionImage.hidden = NO;
        self.questionImage.frame = CGRectMake(0, totalHeight, screenWidth, THUMB_HEIGHT);
        // set the gradient
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
                        self.choiceOne.frame = CGRectMake(8, totalHeight, expectedLabelSize.width, expectedLabelSize.height);
                        totalHeight = totalHeight + expectedLabelSize.height;
                        totalHeight += 8;
                        self.choiceOne.text = answer.text;
                    }
                        break;
                    case 1:
                    {
                        self.choiceTwo.frame = CGRectMake(8, totalHeight, expectedLabelSize.width, expectedLabelSize.height);
                        totalHeight = totalHeight + expectedLabelSize.height;
                        totalHeight += 8;
                        self.choiceTwo.text = answer.text;
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
    
}


@end
