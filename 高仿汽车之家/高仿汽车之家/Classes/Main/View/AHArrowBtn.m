//
//  AHArrowBtn.m
//  高仿汽车之家
//
//  Created by apple on 15/4/7.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHArrowBtn.h"

#define kScale 0.8

@implementation AHArrowBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{

    CGFloat imgX = contentRect.size.width * kScale;
    CGFloat imgY = 0;
    CGFloat imgW = contentRect.size.width * (1 - kScale);
    CGFloat imgH = contentRect.size.height;
    return CGRectMake(imgX, imgY, imgW, imgH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{

    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width * kScale;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
