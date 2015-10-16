//
//  MultipleChoiceButtonTableViewCell.m
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "MultipleChoiceButtonTableViewCell.h"
#import "Question.h"
#import "Answers.h"
#import "Image.h"
#import <UIImageView+WebCache.h>
#import "Constant.h"
#import "ViewController.h"
#import "UserAnswer.h"
#import "UtilityManager.h"
#import "Constant.h"

@implementation MultipleChoiceButtonTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _choiceOne = [[UILabel alloc] initWithFrame:CGRectZero];
        _choiceOne.lineBreakMode =  NSLineBreakByWordWrapping;
        [_choiceOne setFont:ANSWER_LABEL_FONT];
        _choiceOne.layer.cornerRadius = 5.0;
        _choiceOne.userInteractionEnabled = YES;
        _choiceOne.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceOne.numberOfLines = 0;
        _choiceOne.layer.masksToBounds = YES;
        _choiceOne.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_choiceOne];
        
        
        _choiceTwo = [[UILabel alloc] initWithFrame:CGRectZero];
        _choiceTwo.lineBreakMode =  NSLineBreakByWordWrapping;
        [_choiceTwo setFont:ANSWER_LABEL_FONT];
        _choiceTwo.layer.cornerRadius = 5.0;
        _choiceTwo.userInteractionEnabled = YES;
        _choiceTwo.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceTwo.numberOfLines = 0;
        _choiceTwo.layer.masksToBounds = YES;
        _choiceTwo.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_choiceTwo];
        
        _choiceThree = [[UILabel alloc] initWithFrame:CGRectZero];
        _choiceThree.lineBreakMode =  NSLineBreakByWordWrapping;
        [_choiceThree setFont:ANSWER_LABEL_FONT];
        _choiceThree.layer.cornerRadius = 5.0;
        _choiceThree.userInteractionEnabled = YES;
        _choiceThree.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceThree.numberOfLines = 0;
        _choiceThree.layer.masksToBounds = YES;
        _choiceThree.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_choiceThree];
        
        _choiceFour = [[UILabel alloc] initWithFrame:CGRectZero];
        _choiceFour.lineBreakMode =  NSLineBreakByWordWrapping;
        [_choiceFour setFont:ANSWER_LABEL_FONT];
        _choiceFour.layer.cornerRadius = 5.0;
        _choiceFour.userInteractionEnabled = YES;
        _choiceFour.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        _choiceFour.numberOfLines = 0;
        _choiceFour.layer.masksToBounds = YES;
        _choiceFour.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_choiceFour];
        
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
    
    CGRect rect =  [question.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : QUESION_LABEL_FONT } context:nil];
    expectedLabelSize = rect.size;
    
    // Update the Height
    totalHeight = totalHeight + expectedLabelSize.height;
    // Add Padding
    totalHeight += EXTRA_SPACE;
    
    if (question.image && question.image.src) {
        totalHeight = totalHeight + THUMB_HEIGHT + EXTRA_SPACE;
        // new implementation it will always remian open
    }
    
    for (Answers *answer in question.answers ){
        CGRect rect =  [answer.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : ANSWER_LABEL_FONT } context:nil];
        expectedLabelSize = rect.size;
        if (expectedLabelSize.height<MINIMUM_LABEL_HEIGHT) {
            expectedLabelSize.height = MINIMUM_LABEL_HEIGHT;
        }
        totalHeight = totalHeight + expectedLabelSize.height;
        totalHeight += EXTRA_SPACE;
    }
    
    return totalHeight + EXTRA_SPACE;
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
    
    
    //[self.headline setFont:[UIFont systemFontOfSize:QUESION_LABEL_FONT]];
    
    //set Question headline
    CGRect rect =  [question.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : QUESION_LABEL_FONT } context:nil];
    
    expectedLabelSize = rect.size;
    self.headline.frame = CGRectMake(X_PADDING, totalHeight, maximumLabelSize.width, expectedLabelSize.height);
    self.headline.text = question.text;
    totalHeight = totalHeight + expectedLabelSize.height;
    totalHeight = totalHeight + EXTRA_SPACE;
    
    if (question.answers.count==3) {
        _choiceFour.hidden = true;
        _choiceThree.hidden = false;
    }
    else if (question.answers.count==2) {
        _choiceFour.hidden = true;
        _choiceThree.hidden = true;
    }
    else {
        _choiceFour.hidden = false;
        _choiceThree.hidden = false;
    }
    
    
    if (question.image && question.image.src ) {
        self.questionImage.hidden = NO;
        self.questionImage.frame = CGRectMake(X_PADDING, totalHeight, THUMB_WIDTH -  20, THUMB_HEIGHT);
        // set the gradient
        totalHeight = totalHeight + THUMB_HEIGHT + EXTRA_SPACE;
        
        NSString *imageURLString = [[UtilityManager sharedInstance]getImageURLForWidth:THUMB_WIDTH-20 height:THUMB_HEIGHT fromURL:question.image.src];
        //_questionImage.image = [UIImage imageNamed:@"placeholder.png"];
        //Downloading Question image
        [self.questionImage sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         
                                         if (image &&  [image isKindOfClass:[UIImage class]]) {
                                             image = [[UtilityManager sharedInstance] imageResize:image andResizeTo:CGSizeMake(THUMB_WIDTH -  20, THUMB_HEIGHT)];
                                             MultipleChoiceButtonTableViewCell *localCell = (MultipleChoiceButtonTableViewCell*)[weakSelf.tableView cellForRowAtIndexPath:anIndexPath];
                                             if (localCell && [localCell isKindOfClass:[MultipleChoiceButtonTableViewCell class]]) {
                                                 [localCell.questionImage setImage:image];
                                             }
                                         }
                                         else
                                         {
                                             //Need to
                                         }
                                         
                                     }];
    }
    if (question.answers && question.answers.count) {
        // Iterate through the home related objects and fill the view
        for (int i= 0; i<question.answers.count;i++) {
            Answers *answer = [question.answers objectAtIndex:i];
            
            CGRect rect =  [answer.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : ANSWER_LABEL_FONT } context:nil];
            expectedLabelSize = rect.size;
            if (expectedLabelSize.height<MINIMUM_LABEL_HEIGHT) {
                expectedLabelSize.height = MINIMUM_LABEL_HEIGHT;
            }
            
            switch (i) {
                case 0:
                {
                    _choiceOne.frame = CGRectMake(X_PADDING, totalHeight, CHOICE_LABEL_DEFAULT_WIDTH, expectedLabelSize.height);
                    totalHeight = totalHeight + expectedLabelSize.height;
                    totalHeight += EXTRA_SPACE;
                    _choiceOne.text = answer.text;
                    
                    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
                    [tapGesture addTarget:self action:@selector(choiceOneSelected:)];
                    [_choiceOne addGestureRecognizer:tapGesture];
                    
                    
                }
                    break;
                case 1:
                {
                    _choiceTwo.frame = CGRectMake(X_PADDING, totalHeight, CHOICE_LABEL_DEFAULT_WIDTH, expectedLabelSize.height);
                    totalHeight = totalHeight + expectedLabelSize.height;
                    totalHeight += EXTRA_SPACE;
                    _choiceTwo.text = answer.text;
                    
                    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
                    [tapGesture addTarget:self action:@selector(choiceTwoSelected:)];
                    [_choiceTwo addGestureRecognizer:tapGesture];
                    
                }
                    break;
                case 2:
                {
                    _choiceThree.frame = CGRectMake(X_PADDING, totalHeight, CHOICE_LABEL_DEFAULT_WIDTH, expectedLabelSize.height);
                    totalHeight = totalHeight + expectedLabelSize.height;
                    totalHeight += EXTRA_SPACE;
                    _choiceThree.text = answer.text;
                    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
                    [tapGesture addTarget:self action:@selector(choiceThreeSelected:)];
                    [_choiceThree addGestureRecognizer:tapGesture];
                }
                    break;
                case 3:
                {
                    _choiceFour.text = answer.text;
                    _choiceFour.frame = CGRectMake(X_PADDING, totalHeight, CHOICE_LABEL_DEFAULT_WIDTH, expectedLabelSize.height);
                    totalHeight = totalHeight + expectedLabelSize.height;
                    totalHeight += EXTRA_SPACE;
                    
                    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
                    [tapGesture addTarget:self action:@selector(choiceFourSelected:)];
                    [_choiceFour addGestureRecognizer:tapGesture];
                }
                    break;
                    
                default:
                    break;
            }
            
            
            
            // Increase totalHeight by HEIGHT_OF_RELATED_VIEW
            //totalHeight = totalHeight + 8;
        }
    }
    
    _choiceOne.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceOne.textColor = [UIColor blackColor];
    
    _choiceTwo.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceTwo.textColor = [UIColor blackColor];
    
    _choiceThree.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceThree.textColor = [UIColor blackColor];
    
    _choiceFour.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceFour.textColor = [UIColor blackColor];
    
    for (NSString  *questionID in homeViewController.answerDictionary.allKeys) {
        if ([questionID integerValue] == question.questionID) {
            UserAnswer *userAnswer = [homeViewController.answerDictionary objectForKey:questionID];
            for (int i = 0; i<question.answers.count; i++) {
                Answers *answer  = [question.answers objectAtIndex:i];
                if (userAnswer.answerId == answer.answerId) {
                    switch (i) {
                        case 0:
                        {
                            [self setColorLabelsIfChoiceOneSelected];
                        }
                            break;
                        case 1:
                        {
                            [self setColorLabelsIfChoiceTwoSelected];
                        }
                            break;
                        case 2:
                        {
                            [self setColorLabelsIfChoiceThreeSelected];
                        }
                            break;
                        case 3:
                        {
                            [self setColorLabelsIfChoiceFourSelected];
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
    if (homeViewController.answerDictionary.allKeys.count != homeViewController.questionCount) {
        [self setColorLabelsIfChoiceOneSelected];
        [(ViewController*)homeViewController selectedAnswer:[question.answers firstObject] atIndePath:self.indexPath forQuestion:question];
    }
}
-(void)choiceTwoSelected:(UITapGestureRecognizer *)gesture {
    
    if (homeViewController.answerDictionary.allKeys.count != homeViewController.questionCount) {
        [self setColorLabelsIfChoiceTwoSelected];
        Question *question = (Question *)self.data;
        [(ViewController*)homeViewController selectedAnswer:[question.answers objectAtIndex:1] atIndePath:self.indexPath forQuestion:question];
    }
    
}
-(void)choiceThreeSelected:(UITapGestureRecognizer *)gesture {
    
    if (homeViewController.answerDictionary.allKeys.count != homeViewController.questionCount) {
        [self setColorLabelsIfChoiceThreeSelected];
        Question *question = (Question *)self.data;
        [(ViewController*)homeViewController selectedAnswer:[question.answers objectAtIndex:2] atIndePath:self.indexPath forQuestion:question];
    }
}

-(void)choiceFourSelected:(UITapGestureRecognizer *)gesture {
    
    if (homeViewController.answerDictionary.allKeys.count!=homeViewController.questionCount) {
        [self setColorLabelsIfChoiceFourSelected];
        Question *question = (Question *)self.data;
        [(ViewController*)homeViewController selectedAnswer:[question.answers objectAtIndex:3] atIndePath:self.indexPath forQuestion:question];
    }
}


-(void)setColorLabelsIfChoiceOneSelected {
    _choiceOne.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
    _choiceOne.textColor = [UIColor whiteColor];
    
    _choiceTwo.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceTwo.textColor = [UIColor blackColor];
    
    _choiceThree.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceThree.textColor = [UIColor blackColor];
    
    _choiceFour.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceFour.textColor = [UIColor blackColor];
}

-(void)setColorLabelsIfChoiceTwoSelected {
    _choiceTwo.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
    _choiceTwo.textColor = [UIColor whiteColor];
    _choiceOne.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceOne.textColor = [UIColor blackColor];
    
    _choiceThree.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceThree.textColor = [UIColor blackColor];
    
    _choiceFour.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceFour.textColor = [UIColor blackColor];
}

-(void)setColorLabelsIfChoiceThreeSelected {
    
    _choiceThree.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
    _choiceThree.textColor = [UIColor whiteColor];
    
    _choiceOne.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceOne.textColor = [UIColor blackColor];
    
    _choiceTwo.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceTwo.textColor = [UIColor blackColor];
    
    _choiceFour.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceFour.textColor = [UIColor blackColor];
}

-(void)setColorLabelsIfChoiceFourSelected {
    _choiceFour.backgroundColor = CHOICE_LABEL_SELECTED_COLOR;
    _choiceFour.textColor = [UIColor whiteColor];
    
    _choiceThree.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceThree.textColor = [UIColor blackColor];
    
    _choiceOne.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceOne.textColor = [UIColor blackColor];
    
    _choiceTwo.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
    _choiceTwo.textColor = [UIColor blackColor];
}







@end



