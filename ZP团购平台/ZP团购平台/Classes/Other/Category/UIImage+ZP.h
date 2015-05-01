//
//  UIImage+ZP.h
//  东莞团购平台
//
//  Created by apple on 15/3/30.
//  Copyright (c) 2015年 tuangou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZP)


#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

@end
