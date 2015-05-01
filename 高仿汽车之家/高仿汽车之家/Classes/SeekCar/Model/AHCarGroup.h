//
//  AHCarGroup.h
//  高仿汽车之家
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHCarGroup : NSObject

///  car 的组标题（A,B,C,D....Z）
@property(nonatomic,copy)NSString *letter;

///  car 模型数组
@property(nonatomic,strong)NSArray *list;

///  返回内部解析好的模型数组
+ (NSArray *)carArray;
@end
