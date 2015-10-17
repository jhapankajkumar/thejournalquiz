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

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//This is Question Headline Font size
#define QUESTION_LABEL_FONT_SIZE              IS_IPHONE ? 20 : 28
//This is Answer Label font size
#define ANSWER_LABEL_FONT_SIZE                IS_IPHONE ? 16 : 24

//Vertical margin between answers
#define EXTRA_SPACE                             10

//Padding from x-axis
#define X_PADDING                               10

//Padding from Y-Axis
#define Y_PADDING                               10

//Minimum Label height
#define MINIMUM_LABEL_HEIGHT                    100

//Default answer label background color
#define CHOICE_LABEL_DEFAULT_COLOR              RGB(210, 210, 210)

//Selected answer label background color
#define CHOICE_LABEL_SELECTED_COLOR             RGB(90, 145, 0)

//Thumb Widht
#define THUMB_WIDTH                             [UIScreen mainScreen].bounds.size.width

//THUMB_HEIGHT - This is dynamic, calculated based on width of the screen to maintain aspect ratio
#define THUMB_HEIGHT                            (THUMB_WIDTH) * 150/320

//Default Answer label width
#define CHOICE_LABEL_DEFAULT_WIDTH              (THUMB_WIDTH) - 20

//Question Font
#define QUESION_LABEL_FONT  [UIFont fontWithName:@"Avenir-Black" size:QUESTION_LABEL_FONT_SIZE]

//Answer font
#define ANSWER_LABEL_FONT  [UIFont fontWithName:@"Helvetica-Bold" size:ANSWER_LABEL_FONT_SIZE]

//Grid view (Multiple choice question based on image) width
#define CHOICE_VIEW_WIDTH                       (THUMB_WIDTH-30)/2 //X_PADDING + WIDTH + X_PADDING

//Height is equal to width
#define CHOICE_VIEW_HEIGHT                      CHOICE_VIEW_WIDTH

//Grid Image Width
#define CHOICE_IMAGE_THUMB_WIDTH                CHOICE_VIEW_WIDTH - X_PADDING - X_PADDING
#define CHOICE_IMAGE_THUMB_HEIGHT               CHOICE_IMAGE_THUMB_WIDTH

//Image resize
#define IMAGE_RESIZE_VALUE                      CGSizeMake(CHOICE_IMAGE_THUMB_WIDTH,CHOICE_IMAGE_THUMB_HEIGHT)

#define PLACE_HOLDER_IMAGE                      [UIImage imageNamed:@"placeholder.png"]


#endif
