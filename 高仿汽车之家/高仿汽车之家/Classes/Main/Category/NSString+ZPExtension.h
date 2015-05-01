//
//  NSString+ZPExtension.h
//  ZZP微博
//
//  Created by apple on 15/4/11.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

///  传入字符串，追加相应沙盒中的路径

#import <Foundation/Foundation.h>

@interface NSString (ZPExtension)

/**
 *  追加文档目录
 */
- (NSString *)appendDocumentDir;

/**
 *  追加缓存目录
 */
- (NSString *)appendCacheDir;

/**
 *  追加临时目录
 */
- (NSString *)appendTempDir;

@end
