//
//  TGLineLable.m
//  东莞团购平台
//
//  Created by mac on 14-12-25.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGLineLable.h"

@implementation TGLineLable

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.设置颜色
    [self.textColor setStroke];
    
    // 3.画线
    CGFloat y = rect.size.height * 0.4 ;
    CGFloat x = 0;
    CGContextMoveToPoint(ctx, x, y);
    CGFloat endX = [self.text sizeWithFont:self.font].width ;
    CGContextAddLineToPoint(ctx, endX, y);
    
    // 4.渲染
    CGContextStrokePath(ctx);
}

@end
