//
//  NSString+ZP.m
//  东莞团购平台
//
//  Created by apple on 15/3/30.
//  Copyright (c) 2015年 tuangou. All rights reserved.
//

#import "NSString+ZP.h"

@implementation NSString (ZP)
+ (NSString *)stringWithDouble:(double)value fractionCount:(int)fractionCount
{
    if (fractionCount < 0) return nil;
    
    // 1.fmt ---> %.2f
    NSString *fmt = [NSString stringWithFormat:@"%%.%df", fractionCount];
    
    // 2.生成保留fractionCount位小数的字符串
    NSString *str = [NSString stringWithFormat:fmt, value];
    
    // 3.如果没有小数，直接返回
    if ([str rangeOfString:@"."].length == 0) {
        return str;
    }
    
    // 4.不断删除最后一个0 和 最后一个'.'
    NSUInteger index = str.length - 1;
    unichar currentChar = [str characterAtIndex:index];
    
    while (currentChar == '0' ||  currentChar == '.') {
        if (currentChar == '.') {
            return [str substringToIndex:index];
        }
        
        index--;
        currentChar = [str characterAtIndex:index];
    }
    return [str substringToIndex:index + 1];
    
}

@end
