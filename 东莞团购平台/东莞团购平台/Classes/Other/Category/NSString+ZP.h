//
//  NSString+ZP.h
//  东莞团购平台
//
//  Created by apple on 15/3/30.
//  Copyright (c) 2015年 tuangou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZP)

// 生成一个保留fractionCount位小数的字符串(裁剪尾部多余的0)
+ (NSString *)stringWithDouble:(double)value fractionCount:(int)fractionCount;

@end
