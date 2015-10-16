//
//  MultipleChoiceButtonTableViewCell.h
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericTableViewCell.h"
@class ViewController;
@interface MultipleChoiceButtonTableViewCell : GenericTableViewCell
{
    ViewController *homeViewController;
}
@property (strong, nonatomic)  UILabel *headline;
@property (strong, nonatomic)  UIImageView *questionImage;
@property (strong, nonatomic)  UILabel *choiceOne;

@property (strong, nonatomic)  UILabel *choiceTwo;
@property (strong, nonatomic)  UILabel *choiceThree;
@property (strong, nonatomic)  UILabel *choiceFour;
@property (strong, nonatomic)  UIImageView *saperatorImage;
@end


