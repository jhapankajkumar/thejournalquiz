//
//  PersonaCell.m
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "PersonaCell.h"
#import "Question.h"
#import "Answers.h"
#import "Image.h"
#import "Personas.h"
#import "ViewController.h"
#import <UIImageView+WebCache.h>
#import "Constant.h"
#import "ViewController.h"
#import "UtilityManager.h"


@interface PersonaCell () {
    UIButton *shareButton;
    UIButton *tryAgainQuizButton;
}

@end

@interface PersonaCell ()
@property (nonatomic,strong) ViewController* homeViewController;
@end

@implementation PersonaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _resultHeadLine = [[UILabel alloc] initWithFrame:CGRectZero];
        _resultHeadLine.lineBreakMode =  NSLineBreakByWordWrapping;
        [_resultHeadLine setFont:ANSWER_LABEL_FONT];
        _resultHeadLine.layer.cornerRadius = 5.0;
        _resultHeadLine.userInteractionEnabled = YES;
        _resultHeadLine.backgroundColor = [UIColor clearColor];
        _resultHeadLine.numberOfLines = 0;
        _resultHeadLine.layer.masksToBounds = YES;
        _resultHeadLine.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_resultHeadLine];
        
        
        _resultText = [[UILabel alloc] initWithFrame:CGRectZero];
        _resultText.lineBreakMode =  NSLineBreakByWordWrapping;
        [_resultText setFont:ANSWER_LABEL_FONT];
        _resultText.layer.cornerRadius = 5.0;
        _resultText.userInteractionEnabled = YES;
        _resultText.backgroundColor = [UIColor clearColor];
        _resultText.numberOfLines = 0;
        _resultText.layer.masksToBounds = YES;
        _resultText.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_resultText];
        
        _resultImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _resultImage.layer.cornerRadius =  5.0;
        [_resultImage setContentMode:UIViewContentModeScaleAspectFit];
        //_questionImage.contentMode = UIViewContentModeScaleAspectFill;
        
        // Add to Table View Cell
        [self.contentView addSubview:_resultImage];
        
        //self.contentView.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

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
    Personas *persona = (Personas*)aData;
    
    float totalHeight = EXTRA_SPACE;

    CGSize maximumLabelSize = CGSizeMake(screenWidth-20,FLT_MAX);
    CGSize expectedLabelSize;
    
    //if all question has been answered
    if (viewController.answerDictionary.allKeys.count == viewController.questionCount) {
        
        //Headline Text
        CGRect rect =  [persona.title boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : QUESION_LABEL_FONT} context:nil];
        expectedLabelSize = rect.size;
        
        if (expectedLabelSize.height<MINIMUM_LABEL_HEIGHT) {
            expectedLabelSize.height = MINIMUM_LABEL_HEIGHT;
        }
        totalHeight = totalHeight + expectedLabelSize.height;
        totalHeight = totalHeight +  EXTRA_SPACE;
        
        //persona Image
        totalHeight =  totalHeight + THUMB_HEIGHT;
        totalHeight = totalHeight + EXTRA_SPACE;
        
        //Descrptive Text
         rect =  [persona.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : ANSWER_LABEL_FONT} context:nil];
        
        expectedLabelSize = rect.size;
        if (expectedLabelSize.height<MINIMUM_LABEL_HEIGHT) {
            expectedLabelSize.height = MINIMUM_LABEL_HEIGHT;
        }
        totalHeight = totalHeight + expectedLabelSize.height;
        totalHeight = totalHeight + EXTRA_SPACE;
        
        //Share Button
        totalHeight = totalHeight + MINIMUM_LABEL_HEIGHT;
        totalHeight = totalHeight + EXTRA_SPACE;
        
        // Try Again Button
        totalHeight = totalHeight + MINIMUM_LABEL_HEIGHT;
        totalHeight = totalHeight + EXTRA_SPACE;
        
    }
    else {
        //Headline Text
        CGRect rect =  [PERSONA_INFORMATION_TEXT boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : QUESION_LABEL_FONT } context:nil];
        
        expectedLabelSize = rect.size;
        if (expectedLabelSize.height<MINIMUM_LABEL_HEIGHT) {
            expectedLabelSize.height = MINIMUM_LABEL_HEIGHT;
        }
        totalHeight = totalHeight  + expectedLabelSize.height;
        totalHeight = totalHeight + EXTRA_SPACE;
        
        //for blank image placeholder
        
        totalHeight = totalHeight + THUMB_HEIGHT + EXTRA_SPACE;
        
    }
    return totalHeight + EXTRA_SPACE;
}

- (void)createCellForData:(id)aData tableView:(UITableView *)aTableView indexPath:(NSIndexPath *)anIndexPath controller:(id)controller {
    
    [super createCellForData:aData tableView:aTableView indexPath:anIndexPath controller:controller];
    
    self.tableView = aTableView;
    self.data = aData;
    self.indexPath = anIndexPath;
    self.controller = controller;
    
    CGFloat totalHeight = EXTRA_SPACE;
    CGSize maximumLabelSize = CGSizeMake(CHOICE_LABEL_DEFAULT_WIDTH,FLT_MAX);
    CGSize expectedLabelSize;
        for (id subView in self.contentView.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                [subView removeFromSuperview];
            }
        }
    
    ViewController *viewController = (ViewController *)controller;
    Personas *persona = (Personas*)aData;
    
    //if all question has been answered
    if (viewController.answerDictionary.allKeys.count == viewController.questionCount) {
        
        
        //Headline Text
        CGRect rect =  [persona.title boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : QUESION_LABEL_FONT } context:nil];
        
        expectedLabelSize = rect.size;
        if (expectedLabelSize.height<MINIMUM_LABEL_HEIGHT) {
            expectedLabelSize.height = MINIMUM_LABEL_HEIGHT;
        }
        self.resultHeadLine.text = persona.title;
        self.resultHeadLine.frame = CGRectMake(X_PADDING, totalHeight, CHOICE_LABEL_DEFAULT_WIDTH, expectedLabelSize.height);
    
        totalHeight = totalHeight + expectedLabelSize.height;
        totalHeight = totalHeight + EXTRA_SPACE;
        
        //Get Persona Image
        self.resultImage.frame = CGRectMake(X_PADDING+X_PADDING, totalHeight, CHOICE_LABEL_DEFAULT_WIDTH-20 , THUMB_HEIGHT);
        totalHeight = totalHeight + THUMB_HEIGHT;
        totalHeight = totalHeight + EXTRA_SPACE;
        
        NSString *imageURLString = [[UtilityManager sharedInstance]getImageURLForWidth:CHOICE_LABEL_DEFAULT_WIDTH height:THUMB_HEIGHT fromURL:persona.image.src];
        __weak __typeof(&*self)weakcell = self;
        //Downloading Question image
        [self.resultImage sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                              placeholderImage:PLACE_HOLDER_IMAGE
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         
                                         if (image &&  [image isKindOfClass:[UIImage class]]) {
                                             image = [[UtilityManager sharedInstance] imageResize:image andResizeTo:CGSizeMake(CHOICE_LABEL_DEFAULT_WIDTH, THUMB_HEIGHT)];
                                             
                                             PersonaCell *localCell = (PersonaCell*)[weakcell.tableView cellForRowAtIndexPath:anIndexPath];
                                             if (localCell && [localCell isKindOfClass:[PersonaCell class]]) {
                                                 [localCell.resultImage setImage:image];
                                             }
                                         }
                                         else
                                         {
                                             //Need to
                                         }
                                     }];
        //Descrptive Text
        rect =  [persona.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : ANSWER_LABEL_FONT} context:nil];

        expectedLabelSize = rect.size;
        if (expectedLabelSize.height<MINIMUM_LABEL_HEIGHT) {
            expectedLabelSize.height = MINIMUM_LABEL_HEIGHT;
        }
        
        self.resultText.hidden = false;
        self.resultText.text = persona.text;
        self.resultText.frame = CGRectMake(X_PADDING, totalHeight, CHOICE_LABEL_DEFAULT_WIDTH, expectedLabelSize.height);
        totalHeight = totalHeight +  expectedLabelSize.height;
        totalHeight = totalHeight + EXTRA_SPACE;
        
        
        shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        shareButton.frame = CGRectMake(X_PADDING, totalHeight, CHOICE_LABEL_DEFAULT_WIDTH, MINIMUM_LABEL_HEIGHT);
        [shareButton setTitle:@"Share your result" forState:UIControlStateNormal];
        shareButton.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        [shareButton addTarget:self action:@selector(shareQuiz:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:shareButton];
        
        totalHeight = totalHeight + MINIMUM_LABEL_HEIGHT;
        totalHeight = totalHeight + EXTRA_SPACE;
        
        
        tryAgainQuizButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        tryAgainQuizButton.frame = CGRectMake(X_PADDING, totalHeight,CHOICE_LABEL_DEFAULT_WIDTH, MINIMUM_LABEL_HEIGHT);
        [tryAgainQuizButton setTitle:@"Try Again" forState:UIControlStateNormal];
        tryAgainQuizButton.backgroundColor = CHOICE_LABEL_DEFAULT_COLOR;
        [tryAgainQuizButton addTarget:self action:@selector(tryAgainQuiz:) forControlEvents:UIControlEventTouchUpInside];
        
        totalHeight = totalHeight + MINIMUM_LABEL_HEIGHT;
        totalHeight = totalHeight + EXTRA_SPACE;
        
        [self.contentView addSubview:tryAgainQuizButton];
        
        //Share Button/ Try Again Button
    }
    else {
        self.resultText.hidden = true;
        //Headline Text
        CGRect rect =  [PERSONA_INFORMATION_TEXT boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : QUESION_LABEL_FONT } context:nil];
        expectedLabelSize = rect.size;
        if (expectedLabelSize.height<MINIMUM_LABEL_HEIGHT) {
            expectedLabelSize.height = MINIMUM_LABEL_HEIGHT;
        }
        self.resultHeadLine.text = PERSONA_INFORMATION_TEXT;
        self.resultHeadLine.frame = CGRectMake(X_PADDING, totalHeight, CHOICE_LABEL_DEFAULT_WIDTH, expectedLabelSize.height);
        totalHeight = totalHeight +  expectedLabelSize.height;
        totalHeight = totalHeight + EXTRA_SPACE;
        
        self.resultImage.frame = CGRectMake(X_PADDING+X_PADDING, totalHeight, CHOICE_LABEL_DEFAULT_WIDTH-20, THUMB_HEIGHT);
        self.resultImage.image = PLACE_HOLDER_IMAGE;
    }
    
}


- (void)shareQuiz:(UIButton *)sender {
 
    [(ViewController *)self.controller shareResultWithData:(Personas *)self.data];
    
}

- (void)tryAgainQuiz:(UIButton *)sender {
    [(ViewController *)self.controller retryQuizAgain:sender];
}

@end
