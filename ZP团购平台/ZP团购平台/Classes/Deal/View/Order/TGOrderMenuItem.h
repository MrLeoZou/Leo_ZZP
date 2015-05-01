//
//  TGOrderMenuItem.h
//  东莞团购平台
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 tuangou. All rights reserved.

//排序底部菜单项，继承团购底部菜单项（父类）

#import "TGDealBottomMenuItem.h"

@class TGOrder;
@interface TGOrderMenuItem : TGDealBottomMenuItem

// 需要显示的排序数据 使用TGOrder的模型数据
@property(nonatomic ,strong)TGOrder *order;
@end
