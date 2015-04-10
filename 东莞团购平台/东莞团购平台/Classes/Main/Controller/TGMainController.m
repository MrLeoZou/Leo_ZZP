//
//  TGMainController.m
//  东莞团购平台
//
//  Created by mac on 14-11-2.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGMainController.h"
#import "TGDock.h"
#import "TGNavigationController.h"
#import "TGMapController.h"
#import "TGCollectController.h"
#import "TGDealController.h"
#import "TGMoreController.h"

@interface TGMainController ()<DockDelegate, UINavigationControllerDelegate>

@end

@implementation TGMainController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.初始化所有的子控制器
    [self addAllChildControllers];
    
    // 2.初始化DockItems
    [self addDockItems];
    
}

#pragma mark 初始化所有的子控制器
- (void)addAllChildControllers
{
    // 1.团购
    TGDealController *deal = [[TGDealController alloc] init];
    TGNavigationController *nav1 = [[TGNavigationController alloc] initWithRootViewController:deal];
    nav1.delegate = self;
    // self在，添加的子控制器就存在
    [self addChildViewController:nav1];

    
    // 3.地图
    TGMapController *map = [[TGMapController alloc] init];
    TGNavigationController *nav3 = [[TGNavigationController alloc] initWithRootViewController:map];
    nav3.delegate = self;
    [self addChildViewController:nav3];
    
    // 2.收藏
    TGCollectController *collect = [[TGCollectController alloc] init];
    TGNavigationController *nav2 = [[TGNavigationController alloc] initWithRootViewController:collect];
    nav2.delegate = self;
    [self addChildViewController:nav2];
    

    
    // 4.更多
    TGMoreController *more = [[TGMoreController alloc]init];
    TGNavigationController *nav4 = [[TGNavigationController alloc]initWithRootViewController:more];
    nav4.delegate = self;
    [self addChildViewController:nav4];
}


#pragma mark 添加Dock
- (void)addDockItems
{
    
    // 1.设置Dock的背景图片
    _dock.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_common.png"]];
    
    // 2.往Dock里面填充内容
    [_dock addItemWithIcon:@"icon_tabbar_homepage.png" selectedIcon:@"icon_tabbar_homepage_selected.png" title:@"团购"];
    
    [_dock addItemWithIcon:@"icon_homepage_map.png" selectedIcon:@"icon_homepage_map_selected.png" title:@"地图"];
    
    [_dock addItemWithIcon:@"icon_collect.png" selectedIcon:@"icon_collect_selected.png" title:@"收藏"];
    
    [_dock addItemWithIcon:@"icon_tabbar_misc.png" selectedIcon:@"icon_tabbar_misc_selected.png"  title:@"更多"];
}

@end
