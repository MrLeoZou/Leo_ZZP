//
//  TGDistrictMenuItem.h
//  东莞团购平台
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 tuangou. All rights reserved.

//一个商区的底部菜单项，继承父类团购底部菜单项

#import "TGDealBottomMenuItem.h"

@class TGDistrict;
@interface TGDistrictMenuItem : TGDealBottomMenuItem
// 需要显示的商区数据 使用TGDistrict的模型数据
@property(nonatomic ,strong)TGDistrict *district;
@end
