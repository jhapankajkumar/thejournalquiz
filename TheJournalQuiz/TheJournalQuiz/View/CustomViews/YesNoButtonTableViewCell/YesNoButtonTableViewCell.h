//
//  YesNoButtonTableViewCell.h
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericTableViewCell.h"

@interface YesNoButtonTableViewCell : GenericTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headLine;

@property (weak, nonatomic) IBOutlet UIImageView *questionImage;
@property (weak, nonatomic) IBOutlet UILabel *choiceOne;
@property (weak, nonatomic) IBOutlet UILabel *choiceTwo;
@property (weak, nonatomic) IBOutlet UILabel *source;
@property (weak, nonatomic) IBOutlet UIImageView *saperatorImage;
@end
