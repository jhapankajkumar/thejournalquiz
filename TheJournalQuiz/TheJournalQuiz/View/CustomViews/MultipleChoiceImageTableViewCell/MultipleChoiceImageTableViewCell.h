//
//  MultipleChoiceImageTableViewCell.h
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericTableViewCell.h"
@class ViewController;
@interface MultipleChoiceImageTableViewCell : GenericTableViewCell {
    ViewController *homeViewController;
}
@property (strong, nonatomic)  UILabel *headline;
@property (strong, nonatomic)  UIImageView *questionImage;

@property (strong, nonatomic)  UIView *choiceOneView;
@property (strong, nonatomic)  UIImageView *choiceOneImage;

@property (strong, nonatomic)  UIView *choiceTwoView;
@property (strong, nonatomic)  UIImageView *choiceTwoImage;

@property (strong, nonatomic)  UIView *choiceThreeView;
@property (strong, nonatomic)  UIImageView *choiceThreeImage;

@property (strong, nonatomic)  UIView *choiceFourView;
@property (strong, nonatomic)  UIImageView *choiceFourImage;

@property (strong, nonatomic)  UIImageView *saperatorImage;
@property (strong, nonatomic)  UIView *answerBackgroundView;











@end
