//
//  PersonaCell.m
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "PersonaCell.h"
#import "Quesiton.h"
#import "Answers.h"
#import "Image.h"
#import "Personas.h"
#import "ViewController.h"
#import <UIImageView+WebCache.h>
#import "Constant.h"


#define HEAD_LINE_FONT_SIZE             18
#define CAPTION_FONT_SIZE               14
#define QUESTION_FONT_SIZE              12



#define THUMB_WIDTH                 [UIScreen mainScreen].bounds.size.width
#define THUMB_HEIGHT                (THUMB_WIDTH) * 210/320


@interface PersonaCell ()
@property (nonatomic,strong) ViewController* homeViewController;
@end

@implementation PersonaCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowHeightForData:(id)aData tableView:(UITableView*)aTableView indexPath:(NSIndexPath *)anIndexPath controller:(id)controller {
    
    CGFloat screenWidth = aTableView.superview.frame.size.width;
    
    ViewController *viewController = (ViewController *)controller;
    float totalHeight = 0;
    Personas *persona = (Personas*)aData;
    totalHeight += 10;
    totalHeight = THUMB_HEIGHT+1;
    CGSize maximumLabelSize = CGSizeMake(screenWidth-20,FLT_MAX);
    CGSize expectedLabelSize;
    if (viewController.answerDictionary.allKeys.count == viewController.questionCount) {
        
        //Headline Text
        CGRect rect =  [persona.title boundingRectWithSize:maximumLabelSize
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{
                                                                        NSFontAttributeName : [UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]
                                                                        }
                                                              context:nil];
        expectedLabelSize = rect.size;
        if (expectedLabelSize.height<70) {
            expectedLabelSize.height = 70;
        }
        totalHeight = totalHeight + 10 + expectedLabelSize.height;
        
        //Descrptive Text
         rect =  [persona.text boundingRectWithSize:maximumLabelSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{
                                                             NSFontAttributeName : [UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]
                                                             }
                                                   context:nil];
        expectedLabelSize = rect.size;
        if (expectedLabelSize.height<70) {
            expectedLabelSize.height = 70;
        }
        totalHeight = totalHeight + 10 + expectedLabelSize.height;
        
        //Share Button/ Try Again Button
        totalHeight = totalHeight + 10 + 40;
    }
    else {
        //Headline Text
        CGRect rect =  [PERSONA_INFORMATION_TEXT boundingRectWithSize:maximumLabelSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{
                                                             NSFontAttributeName : [UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]
                                                             }
                                                   context:nil];
        expectedLabelSize = rect.size;
        if (expectedLabelSize.height<70) {
            expectedLabelSize.height = 70;
        }
        totalHeight = totalHeight + 10 + expectedLabelSize.height;
    }
    
        // new implementation it will always remian open
    return totalHeight;
}

- (void)createCellForData:(id)aData tableView:(UITableView *)aTableView indexPath:(NSIndexPath *)anIndexPath controller:(id)controller {
    
    [super createCellForData:aData tableView:aTableView indexPath:anIndexPath controller:controller];
    self.contentView.frame = CGRectMake(0, self.contentView.frame.origin.y, aTableView.frame.size.width, self.contentView.frame.size.height);
    CGFloat screenWidth = aTableView.superview.frame.size.width;
    self.tableView = aTableView;
    self.data = aData;
    self.indexPath = anIndexPath;
    CGFloat totalHeight = 10;
    CGSize maximumLabelSize = CGSizeMake(screenWidth - 20,FLT_MAX);
    CGSize expectedLabelSize;
    
    ViewController *viewController = (ViewController *)controller;
    Personas *persona = (Personas*)aData;
    if (viewController.answerDictionary.allKeys.count == viewController.questionCount) {
        
        //Get Persona Image
        self.resultImage.hidden = NO;
        self.resultImage.frame = CGRectMake(8, totalHeight, screenWidth, THUMB_HEIGHT);
        totalHeight = THUMB_HEIGHT+1;
        NSString *imageURLString = persona.image.src;
        __weak __typeof(&*self)weakcell = self;
        //Downloading Question image
        [self.resultImage sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         
                                         if (image &&  [image isKindOfClass:[UIImage class]]) {
                                             PersonaCell *localCell = (PersonaCell*)[weakcell.tableView cellForRowAtIndexPath:anIndexPath];
                                             if (localCell && [localCell isKindOfClass:[PersonaCell class]]) {
                                                 [localCell.resultImage setImage:image];
                                                 //[localCell.questionImage setGradientBackgroundWithStartColor:[UIColor clearColor] endColor:RGBA(0, 0, 0, 0.9)];
                                             }
                                         }
                                         else
                                         {
                                             //Need to
                                         }
                                         
                                     }];
        
        totalHeight = totalHeight + 8 ;
        
        
        //Headline Text
        CGRect rect =  [persona.title boundingRectWithSize:maximumLabelSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{
                                                             NSFontAttributeName : [UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]
                                                             }
                                                context:nil];
        expectedLabelSize = rect.size;
        if (expectedLabelSize.height<70) {
            expectedLabelSize.height = 70;
        }
        self.resultHeadLine.text = persona.title;
        self.resultHeadLine.frame = CGRectMake(8, totalHeight, screenWidth, expectedLabelSize.height);

        totalHeight = totalHeight + 10 + expectedLabelSize.height;
        
        //Descrptive Text
        rect =  [persona.text boundingRectWithSize:maximumLabelSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{
                                                     NSFontAttributeName : [UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]
                                                     }
                                           context:nil];
        expectedLabelSize = rect.size;
        if (expectedLabelSize.height<70) {
            expectedLabelSize.height = 70;
            
        }
        self.resultText.text = persona.text;
        self.resultText.frame = CGRectMake(8, totalHeight, screenWidth, expectedLabelSize.height);
        totalHeight = totalHeight + 10 + expectedLabelSize.height;
        
        //Share Button/ Try Again Button
        totalHeight = totalHeight + 10 + 40;
    }
    else {
        
        self.resultImage.image = [UIImage imageNamed:@"placeholder.png"];
        
        self.resultText.hidden = true;
        //Headline Text
        CGRect rect =  [PERSONA_INFORMATION_TEXT boundingRectWithSize:maximumLabelSize
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{
                                                                        NSFontAttributeName : [UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]
                                                                        }
                                                              context:nil];
        expectedLabelSize = rect.size;
        if (expectedLabelSize.height<70) {
            expectedLabelSize.height = 70;
        }
        self.resultHeadLine.text = PERSONA_INFORMATION_TEXT;
        self.resultHeadLine.frame = CGRectMake(8, totalHeight, screenWidth, expectedLabelSize.height);
        totalHeight = totalHeight + 10 + expectedLabelSize.height;
    }
    
    
//    //set Question headLine
//    CGRect rect =  [question.text boundingRectWithSize:maximumLabelSize
//                                               options:NSStringDrawingUsesLineFragmentOrigin
//                                            attributes:@{
//                                                         NSFontAttributeName : [UIFont systemFontOfSize:HEAD_LINE_FONT_SIZE]
//                                                         }
//                                               context:nil];
//    expectedLabelSize = rect.size;
//    
//    if (expectedLabelSize.height > 160) {
//        self.headLine.frame = CGRectMake(10, totalHeight, maximumLabelSize.width, 160);
//    }
//    else {
//        self.headLine.frame = CGRectMake(10, totalHeight, maximumLabelSize.width, expectedLabelSize.height);
//    }
//    self.headLine.text = question.text;
//    totalHeight = totalHeight + expectedLabelSize.height;
//    totalHeight = totalHeight + 8;
//
    
}


- (IBAction)shareResult:(id)sender {
}
@end
