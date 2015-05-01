//
//  AHChannel.h
//  高仿汽车之家
//
//  Created by apple on 15/4/4.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.


//内容tableview的每一个cell对应的模型

#import <Foundation/Foundation.h>

@interface AHChannel : NSObject
///  序号
@property(nonatomic,copy)NSNumber *order;
///  名字
@property(nonatomic,copy)NSString *name;
///  连接URL
@property(nonatomic,copy)NSString *url;

///  快速传入字典创建一个模型
+ (instancetype)channelWithDict:(NSDictionary *)dict;

///  返回所有频道列表
+ (NSArray *)channel;

@end
