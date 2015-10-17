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
@property (strong, nonatomic)  UIImageView *resultImage;
@property (strong, nonatomic)  UILabel *resultHeadLine;
@property (strong, nonatomic)  UILabel *resultText;
@property (nonatomic,strong) UIActivityIndicatorView *loadingIndicator;


@end
