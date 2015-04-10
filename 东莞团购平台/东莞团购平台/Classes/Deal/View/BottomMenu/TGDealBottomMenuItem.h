//
//  TGDealBottomMenuItem.h
//  东莞团购平台
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 tuangou. All rights reserved.


//所有底部菜单项的父类
#import <UIKit/UIKit.h>

@interface TGDealBottomMenuItem : UIButton

- (NSArray *)titles;  //用于接收不同子类传递过来的名称
@end
