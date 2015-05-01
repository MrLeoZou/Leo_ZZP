//
//  AHMainController.m
//  高仿汽车之家
//
//  Created by apple on 15/4/4.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHMainController.h"
#import "AHDepreciateController.h"
#import "AHForumController.h"
#import "AHHomeController.h"
#import "AHMineController.h"
#import "AHSeekCarController.h"
#import "AHTabbar.h"

#define HomeVcNotification @"HomeVcNotification"
#define ForumVcNotification @"ForumVcNotification"

@interface AHMainController ()<AHTabbarDelegate>
///  记录自定义tabbar
@property(nonatomic,strong)AHTabbar *comTarbar;

@end

@implementation AHMainController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //添加自定义tarbar
    [self addTabbar];
    
    //添加子控制器
    [self addChildVc];

}

///  添加自定义的tabbar
- (void)addTabbar
{
 
    AHTabbar *newTabbar = [[AHTabbar alloc]init];
    newTabbar.frame = self.tabBar.bounds;
    newTabbar.backgroundColor = [UIColor whiteColor];
    newTabbar.delegate = self;
    [self.tabBar addSubview:newTabbar];
    _comTarbar = newTabbar;
    
}

///  移除系统自带的tabbarItem,在这个方法中才能准确拿到系统添加的子控件
-(void)viewWillAppear:(BOOL)animated
{
 
    [super viewWillAppear:animated];
    
    for (UIView *view in self.tabBar.subviews) {
        if (![view isKindOfClass:[AHTabbar class]]) {
            //移除系统自带的tabbarItem
            [view removeFromSuperview];
        }
    }
}

///  添加子控制器
- (void)addChildVc {
    
    [self addChildVcWithName:@"AHHomeVc" image:@"item01" selImage:@"item01_selected"];
    
    [self addChildVcWithName:@"AHForumVc" image:@"item02" selImage:@"item02_selected"];

    [self addChildVcWithName:@"AHSeekVc" image:@"item03" selImage:@"item03_selected"];
    
    [self addChildVcWithName:@"AHDepreciateVc" image:@"item04" selImage:@"item04_selected"];
    
    [self addChildVcWithName:@"AHMineVc" image:@"item05" selImage:@"item05_selected"];
}

///  快速创建子控制器的方法
- (void)addChildVcWithName:(NSString *)name image:(NSString *)image selImage:(NSString *)selImage
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:name bundle:nil];
    UINavigationController *navVc = [sb instantiateInitialViewController];
    
    navVc.view.backgroundColor = [UIColor grayColor];
    
    navVc.topViewController.tabBarItem.image = [UIImage imageNamed:image];
    navVc.topViewController.tabBarItem.selectedImage = [UIImage imageNamed:selImage];
    
    //默认隐藏子控制的导航条和底部工具条
    navVc.topViewController.navigationController.toolbarHidden = YES;
    navVc.topViewController.navigationController.navigationBarHidden = YES;
    
    //调用自定义tabbar的方法，创建对应的item
    [_comTarbar addOneItemWithContorllerItem:navVc.topViewController.tabBarItem];
    
    [self addChildViewController:navVc];
}

///  AHTarbar 的代理方法
- (void)tabbar:(AHTabbar *)tabbar didSelectedFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
    if (0 == to) {   //如果是选中，首页
    //通知首页内容控制器，下拉刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:HomeVcNotification object:nil];
        
    }else if (1 == to){ //如果选中的是，论坛
        
        //通知论坛内容控制器，下拉刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:ForumVcNotification object:nil];
    }
}


-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
