//
//  TGDockController.m
//  东莞团购平台
//
//  Created by mac on 14-11-3.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGDockController.h"
#import "TGDock.h"

@interface TGDockController ()<DockDelegate>

@end

@implementation TGDockController


- (void)viewDidLoad
{
    [super viewDidLoad];
  
    // 1.添加Dock
    [self addDock];
}

#pragma mark 添加Dock
- (void)addDock
{
    TGDock *dock = [[TGDock alloc] init];
    dock.frame = CGRectMake(0, self.view.frame.size.height - kDockHeight, self.view.frame.size.width, kDockHeight);
    dock.delegate = self;
    [self.view addSubview:dock];
    _dock = dock;
}

#pragma mark dock的代理方法
- (void)dock:(TGDock *)dock itemSelectedFrom:(int)from to:(int)to
{
    if (to < 0 || to >= self.childViewControllers.count) return;
    
    // 0.移除旧控制器的view
    UIViewController *oldVc = self.childViewControllers[from];
    [oldVc.view removeFromSuperview];
    
    // 1.取出即将显示的控制器
    UIViewController *newVc = self.childViewControllers[to];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - kDockHeight;
    newVc.view.frame = CGRectMake(0, 0, width, height);
    
    // 2.添加新控制器的view到MainController上面
    [self.view addSubview:newVc.view];
    
    _selectedController = newVc;
}



@end
