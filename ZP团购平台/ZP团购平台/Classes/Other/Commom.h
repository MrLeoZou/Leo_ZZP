//
//  Commom.h
//  东莞团购平台
//
//  Created by mac on 14-11-4.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

// 1.判断是否为iPhone5的宏
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568)
#define IOS7 [[[UIDevice currentDevice] systemVersion]floatValue]>=7

// 2.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态
#define MyLog(...)
#endif

// 3.通知名称
// 3.1 城市改变的通知
#define kCityChangeNote @"city_change"
// 城市分类的通知
#define kCategoryChangeNote @"category_change"
// 城市商区的通知
#define kDistrictChangeNote @"district_change"
// 城市排序的通知
#define kOrderChangeNote @"order_change"
// 城市排序的通知
#define kCollectChangeNote @"collect_change"
// 城市的key
#define kCityKey @"city"

//3.2 监听所有通知（城市、分类、商区、排序）
#define kAddAllNotes(method) \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCityChangeNote object:nil];\
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kDistrictChangeNote object:nil];\
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCategoryChangeNote object:nil];\
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kOrderChangeNote object:nil];


//4. 团购界面Search和Tableview的宽高
#define kSearchBarHeight 35
#define kTableViewWidth (self.view.frame.size.width)
#define kTableViewHeight 340
#define kTableViewCellHeight 30
#define kTableViewHeadHeight 20

//5.设置全局背景色
#define kGlobalBg [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]]

//底部dock栏高度
#define kDockHeight 44

//6.
// 顶部菜单项的宽高
#define kTopMenuItemW 100
#define kTopMenuItemH 45

// 底部菜单项的宽高
#define kBottomMenuItemW 80
#define kBottomMenuItemH 45

//7.所有动画持续时间
#define kDuration 0.3

//8.字符串
#define kAll @"全部"
#define kAllCategory  @"全部分类"
#define kAllDistrict  @"全部商区"

//9.团购详情界面
//右边dock栏的宽度
#define kDetailDockWidth 30

#import "MJExtension.h"
