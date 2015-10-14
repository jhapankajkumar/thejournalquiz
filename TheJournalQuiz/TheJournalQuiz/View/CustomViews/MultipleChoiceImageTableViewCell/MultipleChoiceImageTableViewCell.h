//
//  MultipleChoiceImageTableViewCell.h
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericTableViewCell.h"

@interface MultipleChoiceImageTableViewCell : GenericTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIImageView *questionImage;
@property (weak, nonatomic) IBOutlet UIView *choiceOneView;
@property (weak, nonatomic) IBOutlet UIImageView *choiceOneImage;
@property (weak, nonatomic) IBOutlet UILabel *choiceOneLabel;
@property (weak, nonatomic) IBOutlet UIView *choiceTwoView;
@property (weak, nonatomic) IBOutlet UIImageView *choiceTwoImage;
@property (weak, nonatomic) IBOutlet UILabel *choiceTwoLabel;
@property (weak, nonatomic) IBOutlet UIView *choiceThreeView;
@property (weak, nonatomic) IBOutlet UIImageView *choiceThreeImage;

@property (weak, nonatomic) IBOutlet UILabel *choiceThreeLabel;
@property (weak, nonatomic) IBOutlet UIView *choiceFourView;
@property (weak, nonatomic) IBOutlet UIImageView *choiceFourImage;
@property (weak, nonatomic) IBOutlet UILabel *choiceFourLabel;
@property (weak, nonatomic) IBOutlet UIImageView *saperatorImage;










@end
