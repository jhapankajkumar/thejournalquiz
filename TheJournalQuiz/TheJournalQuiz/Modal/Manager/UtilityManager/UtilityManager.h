//
//  UtilityManager.h
//  TheJournalQuiz
//
//  Created by Kumar on 16/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UtilityManager : NSObject
+ (instancetype)sharedInstance;
/*
 * imageResize : This functions helps us resize image.
 * @params
 - img - image
 - newSize - new size to which image is resized
 */
- (UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize;


/*
 * getImageURLForWidth : This functions helps us get image URL by appending desired with and height
 * @params
 - width - width
 - height - height
 - imageURL - base user 
 */
- (NSString *)getImageURLForWidth:(CGFloat )width height:(CGFloat)height fromURL:(NSString *)imageURL;

@end
