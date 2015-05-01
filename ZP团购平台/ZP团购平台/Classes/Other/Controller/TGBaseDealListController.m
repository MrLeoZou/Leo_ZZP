//
//  TGBaseDealListController.m
//  东莞团购平台
//
//  Created by mac on 14-12-28.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGBaseDealListController.h"
#import "TGDealDetailController.h"
#import "UIBarButtonItem+ZP.h"
#import "TGNavigationController.h"
#import "TGDeal.h"
#import "TGDealCell.h"

@interface TGBaseDealListController ()

@end

@implementation TGBaseDealListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 注册xib
    [self.tableView registerNib:[UINib nibWithNibName:@"TGDealCell" bundle:nil] forCellReuseIdentifier:@"deal"];
    
    //2.设置背景颜色
    self.tableView.backgroundColor = kGlobalBg;
}

#pragma mark - tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.totalDeals.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"deal" ;
    //1.先拿到标记去缓冲池中找
    TGDealCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    //3.设置cell的属性
    cell.deal = self.totalDeals[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //显示详情控制器
    [self showDetailController: self.totalDeals[indexPath.row]];
    
}

#pragma mark 显示详情控制器
-(void)showDetailController:(TGDeal *)deal
{
    //1.创建控制器
    TGDealDetailController *detail = [[TGDealDetailController alloc]init];
    //2.创建导航栏左上角按钮
    detail.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"btn_nav_close.png" highlightedIcon:@"btn_nav_close_hl.png" target:self action:@selector(hideDetailController)];
    //3.设置数据
    detail.deal = deal;
    //4.包装详情控制器
    TGNavigationController *nav = [[TGNavigationController alloc]initWithRootViewController:detail];
    nav.view.frame = CGRectMake(320, 0, 320, 568 - kDockHeight);
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    
    //5.使用动画展示
    [UIView animateWithDuration:kDuration animations:^{
        CGRect f = nav.view.frame;
        f.origin.x -= 320;
        nav.view.frame = f;
    }];
}

#pragma mark 隐藏详情控制器
-(void)hideDetailController
{
    //1.获得当前导航控制器
    UIViewController *nav = [self.navigationController.childViewControllers lastObject];
    
    //2.移除导航控制器
    [UIView animateWithDuration:kDuration animations:^{
        CGRect f = nav.view.frame;
        f.origin.x += 320;
        nav.view.frame = f;
    }completion:^(BOOL finished) {
        [nav removeFromParentViewController];
        [nav.view removeFromSuperview];
    }];
    
}

#pragma mark 移除所有通知
-(void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
