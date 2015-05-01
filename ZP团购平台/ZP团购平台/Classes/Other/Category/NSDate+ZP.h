//
//  NSDate+ZP.h
//  东莞团购平台
//
//  Created by apple on 15/3/30.
//  Copyright (c) 2015年 tuangou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZP)

+ (NSDateComponents *)compareFrom:(NSDate *)from to:(NSDate *)to;

- (NSDateComponents *)compare:(NSDate *)other;

@end
