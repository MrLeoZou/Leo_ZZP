//
//  NSString+ZPExtension.m
//  ZZP微博
//
//  Created by apple on 15/4/11.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "NSString+ZPExtension.h"

@implementation NSString (ZPExtension)

-(NSString *)appendDocumentDir
{

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    return  [path stringByAppendingPathComponent:self];
}

-(NSString *)appendCacheDir
{

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [path stringByAppendingPathComponent:self];
}

-(NSString *)appendTempDir
{

    NSString *path = NSTemporaryDirectory();
    return [path stringByAppendingPathComponent:self];
}
@end
