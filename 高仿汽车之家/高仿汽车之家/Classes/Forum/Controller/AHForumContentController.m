//
//  AHForumContentController.m
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHForumContentController.h"
#import "AHForumChannel.h"
#import "AHForumViewCell.h"
#import "AHForum.h"
#import <MJRefresh.h>
#import "AHForumDetailController.h"

#define ForumVcNotification @"ForumVcNotification"

@interface AHForumContentController ()
@property(nonatomic,strong)NSArray *forumsList;
@end

@implementation AHForumContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置下拉刷新
    [self pullDownRefresh];
    
    //监听通知,tabbar一旦切换到当前控制器，就刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pullDownRefresh) name:ForumVcNotification object:nil];
}

///  下拉刷新方法
- (void)pullDownRefresh
{
    
    // 添加动画图片的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self.tableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [self.tableView.gifHeader beginRefreshing];
}

///下啦刷新，加载新数据
- (void)loadNewData
{
    //    NSLog(@"%s",__func__);
    
    //重新请求数据
    __weak typeof(self) weakSelf = self;
    [AHForum forumListWithURLString:self.ForumChannel.value complection:^(NSArray *forumList) {
        //请求成功，设置当前控制器的新闻数组
        //刷新表格
        weakSelf.forumsList = forumList;
    }];
    
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.tableView.header endRefreshing];
}



///  外界一旦重新设置频道，就重新发送请求，加载数据
-(void)setForumChannel:(AHForumChannel *)ForumChannel
{

    _ForumChannel = ForumChannel;
    //发送网络请求
    __weak typeof(self) weakSelf = self;
    [AHForum forumListWithURLString:ForumChannel.value complection:^(NSArray *forumList) {
        //请求成功，设置当前控制器的新闻数组
        weakSelf.forumsList = forumList;
    }];
}


///  拦截新闻数据更新，数据一刷新，就刷新表格
- (void)setForumsList:(NSArray *)forumsList
{

    _forumsList = forumsList;
    //数据一刷新，就刷新表格
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
    return self.forumsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AHForum *forum = self.forumsList[indexPath.row];
    static NSString *ID = @"forumCell";
    
    AHForumViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.forum = forum;
    
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AHForumDetailController *detailVc = [[AHForumDetailController alloc] init];
    AHForum *forum = self.forumsList[indexPath.row];
    detailVc.forum = forum;
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.parentViewController.navigationController pushViewController:detailVc animated:YES];
}
@end
