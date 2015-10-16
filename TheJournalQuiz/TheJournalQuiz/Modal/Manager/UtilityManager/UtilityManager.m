//
//  UtilityManager.m
//  TheJournalQuiz
//
//  Created by Kumar on 16/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//

#import "UtilityManager.h"


@implementation UtilityManager

+ (instancetype)sharedInstance
{
    static UtilityManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UtilityManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}


-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    /*You can remove the below comment if you dont want to scale the image in retina   device .Dont forget to comment UIGraphicsBeginImageContextWithOptions*/
    UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    //[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0,0,newSize.width,newSize.height)
                                //cornerRadius:4.0] addClip];
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (NSString *)getImageURLForWidth:(CGFloat )width height:(CGFloat)height fromURL:(NSString *)imageURL {
    NSString *imageURLString = [NSString stringWithFormat:@"%@?width=%f&height=%f",imageURL,width,height];
    return imageURLString;
}


@end
