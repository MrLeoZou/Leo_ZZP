//
//  TGNavigationController.m
//  东莞团购平台
//
//  Created by mac on 14-11-2.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

//用来控制整个项目的导航栏

#import "TGNavigationController.h"

@interface TGNavigationController ()

@end

@implementation TGNavigationController


- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

#pragma mark 只在这个类第一次使用时才会调用
+(void)initialize
{
    // 1.appearance方法返回一个导航栏的外观对象
    // 修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *bar = [UINavigationBar appearance];
    
    // 2.设置导航栏的背景图片
    [bar setBackgroundImage:[UIImage imageNamed:@"bg_button_extra_hl@2x.png"] forBarMetrics:UIBarMetricsDefault];
    
    // 3.设置导航栏文字的主题
    [bar setTitleTextAttributes:@{
                                  NSFontAttributeName:[UIFont systemFontOfSize:16],
                                  NSForegroundColorAttributeName : [UIColor blackColor],
                                  }];
    
    // 4.修改所有UIBarButtonItem的外观
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    // 修改item的背景图片
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    // 5.设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
@end

