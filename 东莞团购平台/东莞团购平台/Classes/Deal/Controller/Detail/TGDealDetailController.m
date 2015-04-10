//
//  TGDealDetailController.m
//  东莞团购平台
//
//  Created by mac on 14-12-25.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGDealDetailController.h"
#import "TGDeal.h"
#import "UIBarButtonItem+ZP.h"
#import "TGBuyDock.h"
#import "TGDetailDock.h"
#import "TGDealInfoController.h"
#import "TGDealWebController.h"
#import "TGMerchantController.h"
#import "TGCollectTool.h"

@interface TGDealDetailController ()<TGDetailDockDelegate>
{

    TGDetailDock *_detailDock;
}
@end

@implementation TGDealDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //1.基本设置
    [self baseSetting];
    
    //2.添加顶部购买栏
    [self addBuyDock];
    
    //3.添加右边详情dock
    [self addDetailDock];
    
    //4.初始化dock的子控制器
    [self addAllChildViewControllers];
}

#pragma mark 基本设置
-(void)baseSetting
{

    //1.设置背景
    self.view.backgroundColor = kGlobalBg;
    
    //2.设置标题
    self.title = _deal.title;
    
    //3.处理，设置团购的收藏属性是否选择
    [[TGCollectTool sharedTGCollectTool] handleDeal:_deal];
    
    //4.设置右上角按钮
    NSString *collectIcon = _deal.collected ? @"ic_collect_suc.png" : @"ic_deal_collect.png";
    self.navigationItem.rightBarButtonItems = @[
    [UIBarButtonItem itemWithIcon:@"btn_share.png" highlightedIcon:@"btn_share_pressed.png" target:nil action:nil],
    [UIBarButtonItem itemWithIcon:collectIcon highlightedIcon:@"ic_deal_collect_pressed.png" target:self action:@selector(collectClick)]];
    
    // 5.监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectChange) name:kCollectChangeNote object:nil];
}

#pragma mark 点击收藏按钮
-(void)collectClick
{
 
     //1.设置收藏状态
    if (_deal.collected) { // 取消
        [[TGCollectTool sharedTGCollectTool] uncollectDeal:_deal];
    } else { // 收藏
        [[TGCollectTool sharedTGCollectTool] collectDeal:_deal];
    }
    
    //2.发出通知，收藏改变
    [[NSNotificationCenter defaultCenter] postNotificationName:kCollectChangeNote object:nil];
}

#pragma mark 添加顶部购买栏
-(void)addBuyDock
{
     TGBuyDock *buyDock = [TGBuyDock buyDockXib];
     buyDock.deal = _deal;
     buyDock.frame = CGRectMake(0, 0, 320, 45);
    [self.view addSubview: buyDock];

}

#pragma mark 添加右边详情dock
-(void)addDetailDock
{
    TGDetailDock *detailDock = [TGDetailDock detailDockXib];
    detailDock.frame = CGRectMake(290, 200, 0, 0);
    detailDock.delegate = self;
    [self.view addSubview: detailDock];
    _detailDock = detailDock;
    
}

#pragma mark 初始化dock的所有子控制器
-(void)addAllChildViewControllers
{
    //1.团购简介
    TGDealInfoController *info = [[TGDealInfoController alloc]init];
    info.deal = _deal;
    
    [self addChildViewController:info];
    //默认选中团购简介
    [self detailDock:nil btnClickFrom:0 to:0];
    
    //2.图文详情
    TGDealWebController *web = [[TGDealWebController alloc]init];
    web.deal = _deal;
    [self addChildViewController:web];
    
    //3.商家信息
    TGMerchantController *merchant = [[TGMerchantController alloc]init];
    merchant.deal = _deal;
    [self addChildViewController:merchant];
}

#pragma mark dock的代理方法
-(void)detailDock:(TGDetailDock *)detailDock btnClickFrom:(int)from to:(int)to
{
  
    //1.移除就控制的View
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    //2.添加新的控制器View
    UIViewController *new = self.childViewControllers[to];
    new.view.frame = CGRectMake(0, 0, self.view.frame.size.width - _detailDock.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:new.view atIndex:0];
}

#pragma mark 收藏状态改变
- (void)collectChange
{
    [[TGCollectTool sharedTGCollectTool] handleDeal:_deal];
    UIButton *btn = (UIButton *)[self.navigationItem.rightBarButtonItems[1] customView];
    if (_deal.collected) {
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_collect_suc.png"] forState:UIControlStateNormal];
    } else {
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_deal_collect.png"] forState:UIControlStateNormal];
    }
}

@end
