//
//  MultipleChoiceButtonTableViewCell.h
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericTableViewCell.h"

@interface MultipleChoiceButtonTableViewCell : GenericTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIImageView *questionImage;
@property (weak, nonatomic) IBOutlet UILabel *choiceOne;

@property (weak, nonatomic) IBOutlet UILabel *choiceTwo;
@property (weak, nonatomic) IBOutlet UILabel *choiceThree;
@property (weak, nonatomic) IBOutlet UILabel *choiceFour;
@property (weak, nonatomic) IBOutlet UIImageView *saperatorImage;
@end
