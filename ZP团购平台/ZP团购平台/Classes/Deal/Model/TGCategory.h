//
//  TGCategory.h
//  东莞团购平台
//
//  Created by mac on 14-11-23.
//  Copyright (c) 2014年 tuangou. All rights reserved.


//分类模型

#import "TGBaseModel.h"

//继承最基本父类，就有了name属性
@interface TGCategory : TGBaseModel

//定义剩下的两个属性
@property(nonatomic , copy)NSString *icon; //图标
@property(nonatomic , strong)NSArray *subcategories; //分区
@end
