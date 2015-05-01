//
//  AHNetWorkCheck.h
//  高仿汽车之家
//
//  Created by apple on 15/4/24.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.


//用于检测网络连接的工具类

#import <Foundation/Foundation.h>

@interface AHNetWorkCheck : NSObject

@property(nonatomic,assign,getter=isConnected)BOOL isConnected;

///  全局访问入口
+ (instancetype)shareCheck;

///检测网络状态
- (void)checkNetConnect;

@end
