//
//  MultipleChoiceImageTableViewCell.m
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "MultipleChoiceImageTableViewCell.h"
#import "Question.h"
#import "Answers.h"
#import "Image.h"
#import <UIImageView+WebCache.h>
#import "ViewController.h"
#import "Constant.h"
#import "UserAnswer.h"
#import "UtilityManager.h"








@implementation MultipleChoiceImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _choiceOneView = [[UIView alloc] initWithFrame:CGRectZero];
        _choiceOneView.layer.cornerRadius = 5.0;
        _choiceOneView.userInteractionEnabled = YES;
        _choiceOneView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceOneImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_choiceOneView addSubview:_choiceOneImage];
        [self.contentView addSubview:_choiceOneView];
        
        _choiceTwoView = [[UIView alloc] initWithFrame:CGRectZero];
        _choiceTwoView.layer.cornerRadius = 5.0;
        _choiceTwoView.userInteractionEnabled = YES;
        _choiceTwoView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceTwoImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_choiceTwoView addSubview:_choiceTwoImage];
        [self.contentView addSubview:_choiceTwoView];
        
        _choiceThreeView = [[UIView alloc] initWithFrame:CGRectZero];
        _choiceThreeView.layer.cornerRadius = 5.0;
        _choiceThreeView.userInteractionEnabled = YES;
        _choiceThreeView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceThreeImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_choiceThreeView addSubview:_choiceThreeImage];
        [self.contentView addSubview:_choiceThreeView];
        
        _choiceFourView = [[UIView alloc] initWithFrame:CGRectZero];
        _choiceFourView.layer.cornerRadius = 5.0;
        _choiceFourView.userInteractionEnabled = YES;
        _choiceFourView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceFourImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_choiceFourView addSubview:_choiceFourImage];
        [self.contentView addSubview:_choiceFourView];
        
        
        _headline = [[UILabel alloc] initWithFrame:CGRectZero];
        _headline.lineBreakMode =  NSLineBreakByWordWrapping;
        [_headline setFont:QUESION_LABEL_FONT];
        _headline.layer.cornerRadius = 5.0;
        _headline.userInteractionEnabled = YES;
        _headline.backgroundColor = [UIColor clearColor];
        _headline.numberOfLines = 0;
        [self.contentView addSubview:_headline];
        
        _questionImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _questionImage.layer.cornerRadius =  5.0;
        //_questionImage.contentMode = UIViewContentModeScaleAspectFill;
        
        // Add to Table View Cell
        [self.contentView addSubview:_questionImage];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+ (CGFloat)rowHeightForData:(id)aData tableView:(UITableView*)aTableView indexPath:(NSIndexPath *)anIndexPath controller:(id)controller {
    
    CGFloat screenWidth = aTableView.superview.frame.size.width;
    Question *question = (Question*)aData;
    // Init with base padding
    float totalHeight = EXTRA_SPACE;
    
    CGSize maximumLabelSize = CGSizeMake(screenWidth-20,FLT_MAX);
    CGSize expectedLabelSize;
    
    CGRect rect =  [question.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : QUESION_LABEL_FONT} context:nil];
    
    expectedLabelSize = rect.size;
    // Update the Height
    totalHeight = totalHeight + expectedLabelSize.height;
    // Add Padding
    totalHeight += EXTRA_SPACE;
    
    if (question.image && question.image.src) {
        totalHeight = totalHeight + THUMB_HEIGHT+ EXTRA_SPACE;
    }
    
    if (question.answers.count==4) {
        totalHeight = totalHeight + CHOICE_VIEW_HEIGHT + EXTRA_SPACE + CHOICE_VIEW_HEIGHT + EXTRA_SPACE;
    }
    else {
        totalHeight = totalHeight + CHOICE_VIEW_HEIGHT + EXTRA_SPACE ;
    }
    totalHeight += EXTRA_SPACE;
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
    
    
    CGFloat totalHeight = EXTRA_SPACE;
    CGSize maximumLabelSize = CGSizeMake(screenWidth - 20,FLT_MAX);
    CGSize expectedLabelSize;
    
    //set Question headline
    CGRect rect =  [question.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : QUESION_LABEL_FONT } context:nil];
    expectedLabelSize = rect.size;
    self.headline.frame = CGRectMake(X_PADDING, totalHeight, CHOICE_LABEL_DEFAULT_WIDTH, expectedLabelSize.height);
    self.headline.text = question.text;
    totalHeight = totalHeight + expectedLabelSize.height;
    totalHeight = totalHeight + EXTRA_SPACE;
    
    if (question.image && question.image.src ) {
        self.questionImage.hidden = NO;
        self.questionImage.frame = CGRectMake(X_PADDING, totalHeight, THUMB_WIDTH-20, THUMB_HEIGHT);
        // set the gradient
        totalHeight = totalHeight + THUMB_HEIGHT+ EXTRA_SPACE;
        
        NSString *imageURLString = [[UtilityManager sharedInstance] getImageURLForWidth:THUMB_WIDTH-20 height:THUMB_HEIGHT fromURL:question.image.src];
        //Downloading Question image
        [self.questionImage sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         
                                         if (image &&  [image isKindOfClass:[UIImage class]]) {
                                             MultipleChoiceImageTableViewCell *localCell = (MultipleChoiceImageTableViewCell*)[weakSelf.tableView cellForRowAtIndexPath:anIndexPath];
                                             if (localCell && [localCell isKindOfClass:[MultipleChoiceImageTableViewCell class]]) {
                                                 [localCell.questionImage setImage:image];
                                                 //[localCell.questionImage setGradientBackgroundWithStartColor:[UIColor clearColor] endColor:RGBA(0, 0, 0, 0.9)];
                                             }
                                         }
                                         else
                                         {
                                             //Need to
                                         }
                                         
                                     }];
    }
    else {
       self.questionImage.hidden = YES;
    }
    
    if (question.answers.count==2) {
        _choiceThreeView.hidden = true;
        _choiceFourView.hidden = true;
    }
    else {
        _choiceThreeView.hidden = false;
        _choiceFourView.hidden = false;
    }
    
        if (question.answers && question.answers.count) {
            // Iterate through the home related objects and fill the view
            for (int i= 0; i<question.answers.count;i++) {
                Answers *answer = [question.answers objectAtIndex:i];
                switch (i) {
                    case 0:
                    {
                        _choiceOneView.frame = CGRectMake(X_PADDING, totalHeight, CHOICE_VIEW_WIDTH, CHOICE_VIEW_HEIGHT);
                        _choiceOneImage.frame = CGRectMake(X_PADDING, Y_PADDING, CHOICE_IMAGE_THUMB_WIDTH, CHOICE_IMAGE_THUMB_HEIGHT);
                        NSString *imageURLString = [[UtilityManager sharedInstance]getImageURLForWidth:CHOICE_IMAGE_THUMB_WIDTH height:CHOICE_IMAGE_THUMB_HEIGHT fromURL:answer.image.src];
                        
                        //Downloading Question image
                        [_choiceOneImage sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                         
                                                         if (image &&  [image isKindOfClass:[UIImage class]] ) {
                                                             image = [[UtilityManager sharedInstance] imageResize:image andResizeTo:IMAGE_RESIZE_VALUE];
                                                             MultipleChoiceImageTableViewCell *localCell = (MultipleChoiceImageTableViewCell*)[weakSelf.tableView cellForRowAtIndexPath:anIndexPath];
                                                             if (localCell && [localCell isKindOfClass:[MultipleChoiceImageTableViewCell class]]) {
                                                                 [localCell.choiceOneImage setImage:image];
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
                        _choiceTwoView.frame = CGRectMake(X_PADDING + CHOICE_VIEW_WIDTH + X_PADDING, totalHeight, CHOICE_VIEW_WIDTH, CHOICE_VIEW_HEIGHT);
                        _choiceTwoImage.frame = CGRectMake(X_PADDING, Y_PADDING, IMAGE_RESIZE_VALUE.width, IMAGE_RESIZE_VALUE.height);
                        totalHeight = totalHeight + CHOICE_VIEW_HEIGHT + EXTRA_SPACE ;
                        
                        NSString *imageURLString = [[UtilityManager sharedInstance]getImageURLForWidth:IMAGE_RESIZE_VALUE.width height:IMAGE_RESIZE_VALUE.height fromURL:answer.image.src];
                        
                        //Downloading Question image
                        [_choiceTwoImage sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                         
                                                         if (image &&  [image isKindOfClass:[UIImage class]]) {
                                                             image = [[UtilityManager sharedInstance] imageResize:image andResizeTo:IMAGE_RESIZE_VALUE];
                                                             MultipleChoiceImageTableViewCell *localCell = (MultipleChoiceImageTableViewCell*)[weakSelf.tableView cellForRowAtIndexPath:anIndexPath];
                                                             if (localCell && [localCell isKindOfClass:[MultipleChoiceImageTableViewCell class]]) {
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
                        break;
                    case 2:
                    {
                        _choiceThreeView.frame = CGRectMake(X_PADDING, totalHeight, CHOICE_VIEW_WIDTH, CHOICE_VIEW_HEIGHT);
                        _choiceThreeImage.frame = CGRectMake(X_PADDING, Y_PADDING, IMAGE_RESIZE_VALUE.width, IMAGE_RESIZE_VALUE.height);
                        NSString *imageURLString = [[UtilityManager sharedInstance]getImageURLForWidth:IMAGE_RESIZE_VALUE.width height:IMAGE_RESIZE_VALUE.height fromURL:answer.image.src];
                        //Downloading Question image
                        [_choiceThreeImage sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                         
                                                         if (image &&  [image isKindOfClass:[UIImage class]]) {
                                                             image = [[UtilityManager sharedInstance] imageResize:image andResizeTo:IMAGE_RESIZE_VALUE];
                                                             MultipleChoiceImageTableViewCell *localCell = (MultipleChoiceImageTableViewCell*)[weakSelf.tableView cellForRowAtIndexPath:anIndexPath];
                                                             if (localCell && [localCell isKindOfClass:[MultipleChoiceImageTableViewCell class]]) {
                                                                 [localCell.choiceThreeImage setImage:image];
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
                    case 3:
                    {
                        _choiceFourView.frame = CGRectMake(X_PADDING + CHOICE_VIEW_WIDTH + X_PADDING, totalHeight, CHOICE_VIEW_WIDTH, CHOICE_VIEW_HEIGHT);
                        
                        _choiceFourImage.frame = CGRectMake(X_PADDING, Y_PADDING, IMAGE_RESIZE_VALUE.width, IMAGE_RESIZE_VALUE.height);

                        
                        totalHeight = totalHeight + CHOICE_VIEW_HEIGHT + EXTRA_SPACE;
                        NSString *imageURLString = answer.image.src;
                        //Downloading Question image
                        [_choiceFourImage sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                         
                                                         if (image &&  [image isKindOfClass:[UIImage class]]) {
                                                             UIImage* resizedimage = [MultipleChoiceImageTableViewCell imageResize:image andResizeTo:IMAGE_RESIZE_VALUE];
                                                             MultipleChoiceImageTableViewCell *localCell = (MultipleChoiceImageTableViewCell*)[weakSelf.tableView cellForRowAtIndexPath:anIndexPath];
                                                             if (localCell && [localCell isKindOfClass:[MultipleChoiceImageTableViewCell class]]) {
                                                                 [localCell.choiceFourImage setImage:resizedimage];
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
                        
                    default:
                        break;
                }
                // Increase totalHeight by HEIGHT_OF_RELATED_VIEW
                //totalHeight = totalHeight + 8;
            }
        }

    UITapGestureRecognizer *tapGestureChoiceOne = [[UITapGestureRecognizer alloc]init];
    [tapGestureChoiceOne addTarget:self action:@selector(choiceOneSelected:)];
    [_choiceOneView addGestureRecognizer:tapGestureChoiceOne];
    
    UITapGestureRecognizer *tapGestureChoiceTwo = [[UITapGestureRecognizer alloc]init];
    [tapGestureChoiceTwo addTarget:self action:@selector(choiceTwoSelected:)];
    [_choiceTwoView addGestureRecognizer:tapGestureChoiceTwo];
    
    UITapGestureRecognizer *tapGestureChoiceThree = [[UITapGestureRecognizer alloc]init];
    [tapGestureChoiceThree addTarget:self action:@selector(choiceThreeSelected:)];
    [_choiceThreeView addGestureRecognizer:tapGestureChoiceThree];
    
    UITapGestureRecognizer *tapGestureChoiceFour = [[UITapGestureRecognizer alloc]init];
    [tapGestureChoiceFour addTarget:self action:@selector(choiceFourSelected:)];
    [_choiceFourView addGestureRecognizer:tapGestureChoiceFour];
    
    
    _choiceOneView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceTwoView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceThreeView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceFourView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    
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
                            _choiceTwoView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
                            _choiceThreeView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
                            _choiceFourView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
                        }
                            break;
                        case 1:
                        {
                            _choiceTwoView.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
                            _choiceOneView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
                            _choiceThreeView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
                            _choiceFourView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
                        }
                            break;
                        case 2:
                        {
                            _choiceThreeView.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
                            _choiceTwoView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
                            _choiceOneView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
                            _choiceFourView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
                        }
                            break;
                        case 3:
                        {
                            _choiceFourView.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
                            _choiceTwoView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
                            _choiceThreeView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
                            _choiceOneView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
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
        _choiceTwoView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceThreeView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceFourView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        
        [(ViewController*)homeViewController selectedAnswer:[question.answers firstObject] atIndePath:self.indexPath forQuestion:question];
    }
}

-(void)choiceTwoSelected:(UITapGestureRecognizer *)gesture {
    
    if (homeViewController.answerDictionary.allKeys.count!=homeViewController.questionCount) {
        UIView *choiceTwoView =(UIView *) gesture.view;
        choiceTwoView.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
        _choiceOneView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceThreeView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceFourView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        Question *question = (Question *)self.data;
        [(ViewController*)homeViewController selectedAnswer:[question.answers objectAtIndex:1] atIndePath:self.indexPath forQuestion:question];
    }
    
}

-(void)choiceThreeSelected:(UITapGestureRecognizer *)gesture {
    
    if (homeViewController.answerDictionary.allKeys.count!=homeViewController.questionCount) {
        UIView *choiceThreeView =(UIView *) gesture.view;
        choiceThreeView.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
        _choiceTwoView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceOneView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceFourView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        Question *question = (Question *)self.data;
        [(ViewController*)homeViewController selectedAnswer:[question.answers objectAtIndex:2] atIndePath:self.indexPath forQuestion:question ];
    }
}

-(void)choiceFourSelected:(UITapGestureRecognizer *)gesture {
    
    if (homeViewController.answerDictionary.allKeys.count!=homeViewController.questionCount) {
        UIView *choiceFourView =(UIView *) gesture.view;
        choiceFourView.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
        _choiceTwoView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceThreeView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceOneView.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        Question *question = (Question *)self.data;
        [(ViewController*)homeViewController selectedAnswer:[question.answers objectAtIndex:3] atIndePath:self.indexPath forQuestion:question];
    }
    
}


+(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    /*You can remove the below comment if you dont want to scale the image in retina   device .Dont forget to comment UIGraphicsBeginImageContextWithOptions*/
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}




@end
