//
//  YesNoImageTableViewCell.h
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericTableViewCell.h"
@class ViewController;
@interface YesNoImageTableViewCell :GenericTableViewCell {
    ViewController *homeViewController;
}
@property (weak, nonatomic) IBOutlet UILabel *headLine;
@property (weak, nonatomic) IBOutlet UIImageView *questionImage;
@property (weak, nonatomic) IBOutlet UIView *choiceOneView;
@property (weak, nonatomic) IBOutlet UIImageView *choiceOneImage;
@property (weak, nonatomic) IBOutlet UILabel *choiceOneLabel;
@property (weak, nonatomic) IBOutlet UIView *choiceTwoView;
@property (weak, nonatomic) IBOutlet UIImageView *choiceTwoImage;
@property (weak, nonatomic) IBOutlet UILabel *choiceTwoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *separatorImage;



@end
