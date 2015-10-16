//
//  Constant.h
//  TheJournalQuiz
//
//  Created by Kumar on 15/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#ifndef TheJournalQuiz_Constant_h
#define TheJournalQuiz_Constant_h

#define PERSONA_INFORMATION_TEXT  @"Answer all the questions to see your result!"
#define RGB(r, g, b)                            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define QUESTION_LABEL_FONT_SIZE             22
#define CAPTION_FONT_SIZE               14
#define ANSWER_LABEL_FONT_SIZE              16
#define EXTRA_SPACE                     8
#define X_PADDING                       10
#define Y_PADDING                       10
#define MINIMUM_LABEL_HEIGHT            70
#define CHOICE_LABEL_DEFAULT_COLOR              RGB(240, 240, 240)
#define THUMB_WIDTH                 [UIScreen mainScreen].bounds.size.width
#define THUMB_HEIGHT                (THUMB_WIDTH) * 150/320
#define CHOICE_LABEL_DEFAULT_WIDTH   (THUMB_WIDTH) - 20
#define QUESION_LABEL_FONT  [UIFont fontWithName:@"Avenir-Black" size:QUESTION_LABEL_FONT_SIZE]
#define ANSWER_LABEL_FONT  [UIFont fontWithName:@"Helvetica" size:ANSWER_LABEL_FONT_SIZE]


#define CHOICE_VIEW_WIDTH          (THUMB_WIDTH-30)/2 //X_PADDING + WIDTH + X_PADDING
#define CHOICE_VIEW_HEIGHT         CHOICE_VIEW_WIDTH

#define CHOICE_IMAGE_THUMB_WIDTH   CHOICE_VIEW_WIDTH - X_PADDING - X_PADDING
#define CHOICE_IMAGE_THUMB_HEIGHT  CHOICE_IMAGE_THUMB_WIDTH

#define IMAGE_RESIZE_VALUE            CGSizeMake(CHOICE_IMAGE_THUMB_WIDTH,CHOICE_IMAGE_THUMB_HEIGHT)


#endif
