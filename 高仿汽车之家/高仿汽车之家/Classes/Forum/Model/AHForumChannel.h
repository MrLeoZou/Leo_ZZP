//
//  AHForumChannel.h
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHForumChannel : NSObject

///  标题名字
@property(nonatomic,copy)NSString *name;
///  id的值
@property(nonatomic,assign)int value;
///  类型
@property(nonatomic,assign)int type;


///  快速传入字典创建一个模型
+ (instancetype)channelWithDict:(NSDictionary *)dict;

///  返回所有频道列表
+ (NSArray *)channel;
@end
