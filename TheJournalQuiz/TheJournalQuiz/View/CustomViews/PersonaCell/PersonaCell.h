//
//  PersonaCell.h
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericTableViewCell.h"

@interface PersonaCell : GenericTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *resultImage;
@property (weak, nonatomic) IBOutlet UILabel *resultHeadLine;
@property (weak, nonatomic) IBOutlet UILabel *resultText;


@end
