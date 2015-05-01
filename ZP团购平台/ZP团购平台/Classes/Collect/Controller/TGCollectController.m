//
//  TGCollectController.m
//  东莞团购平台
//
//  Created by mac on 14-11-3.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGCollectController.h"
#import "TGCollectTool.h"
#import "TGDealCell.h"

@interface TGCollectController ()

@end

@implementation TGCollectController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.设置标题
    self.title = @"我的收藏";
    
    //2.监听TGDealDetailController发出的收藏改变通知
    //调用tableView的relodata方法，刷新表格
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:kCollectChangeNote object:nil];

}

#pragma mark 实现父类的方法，设置自己团购数据
-(NSArray *)totalDeals
{

    return [TGCollectTool sharedTGCollectTool].collectedDeals;
}

@end
