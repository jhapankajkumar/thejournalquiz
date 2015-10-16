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
- (UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize;
- (NSString *)getImageURLForWidth:(CGFloat )width height:(CGFloat)height fromURL:(NSString *)imageURL;

@end
