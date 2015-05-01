//
//  AHBaseContentController.m
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHBaseContentController.h"
#import "AHNews.h"
#import "AHChannel.h"
#import "AHNewsCell.h"
#import <MJRefresh.h>
#import "NSArray+Log.h"
#import "AHBulletinDetailController.h"
#import "AHNewestDetailController.h"

#define HomeVcNotification @"HomeVcNotification"

@interface AHBaseContentController ()
///  存放新闻模型的数组
@property(nonatomic,strong)NSArray *newsList;
///  作为cell高度的缓冲池
@property(nonatomic,strong)NSCache *cellCache;
@end

@implementation AHBaseContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置下拉刷新
    [self pullDownRefresh];
    
    //监听通知,tabbar一旦切换到当前控制器，就刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pullDownRefresh) name:HomeVcNotification object:nil];

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

///下拉刷新，加载新数据
- (void)loadNewData
{
    //    NSLog(@"%s",__func__);
    //重新请求数据
    //如果是快报，则请求 快报 特有的数据
    __weak typeof(self) weakSelf = self;
    if ([_channel.name isEqualToString:@"快报"]) {
        //        NSLog(@"我是快报界面 -- url=%@",channel.url);
        [AHNews bulletinListWithURLString:_channel.url complection:^(NSArray *bulletinList) {
            weakSelf.newsList = bulletinList;
        }];
    }else if([_channel.name isEqualToString:@"最新"]){  //最新界面，需要插入一条
        
        [AHNews newsListWithURLString:_channel.url isNewest:YES complection:^(NSArray *newsList) {
            
            weakSelf.newsList = newsList;
//            DDLogInfo(@"%@",newsList);
        }];
    }else{    //其他界面
        
        [AHNews newsListWithURLString:_channel.url isNewest:NO complection:^(NSArray *newsList) {
          
            weakSelf.newsList = newsList;
        }];
    }
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.tableView.header endRefreshing];
}


///  外界一旦重新设置频道，就重新发送请求，加载数据
-(void)setChannel:(AHChannel *)channel
{

    _channel = channel;
//    NSLog(@"name -- %@",channel.name);
    //发送网络请求
    //如果是快报，则请求 快报 特有的数据
    __weak typeof(self) weakSelf = self;
    if ([channel.name isEqualToString:@"快报"]) {
//        NSLog(@"我是快报界面 -- url=%@",channel.url);
        [AHNews bulletinListWithURLString:channel.url complection:^(NSArray *bulletinList) {
            weakSelf.newsList = bulletinList;
        }];
        
    }else if([_channel.name isEqualToString:@"最新"]){  //最新界面，需要插入一条
        
        [AHNews newsListWithURLString:_channel.url isNewest:YES complection:^(NSArray *newsList) {
            
            weakSelf.newsList = newsList;
        }];
        
    }else{    //其他界面
        
        [AHNews newsListWithURLString:_channel.url isNewest:NO complection:^(NSArray *newsList) {
            
            weakSelf.newsList = newsList;
        }];
    }
}

///  拦截新闻数据更新，数据一刷新，就刷新表格
-(void)setNewsList:(NSArray *)newsList
{
//    NSLog(@"请求到的最新数据：%@\n",newsList);
    
    _newsList = newsList;
    //数据一刷新，就刷新表格
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
   
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AHNews *news = self.newsList[indexPath.row];
    NSString *ID = [AHNewsCell cellIdentifier:news];
    
    AHNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.news = news;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出当前行的模型
    AHNews *news = self.newsList[indexPath.row];
    //取出对应行的cell
    NSString *ID = [AHNewsCell cellIdentifier:news];
    
    AHNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
  
    //从NSCache中取出缓存的行高
    NSNumber *cellH = [_cellCache objectForKey:news.id];
    CGFloat cellHeight = [cellH doubleValue];
    
    //如果行高为0，则调用自定义cell的方法，计算当前行高
    if ([cellH intValue] == 0) {
        cellHeight = [cell heigthForRowWithNews:news];
        //存储到缓存中
        [_cellCache setObject:@(cellHeight) forKey:news.id];
    }
    return cellHeight;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_channel.name isEqualToString:@"最新"]){
        
        AHNewestDetailController *newestDetailVc = [[AHNewestDetailController alloc]init];
        //传递选中行的模型
//        if (0 == indexPath.row) { //表示选中第一行cell，头条
//            newestDetailVc.isTop = YES;
//        }else{
//        
//            newestDetailVc.isTop = NO;
//        }
#warning 不确定什么时候有头条？先默认没有处理
        newestDetailVc.isTop = NO;
        newestDetailVc.isImageView = NO;
        
        newestDetailVc.isNewest = YES;
        newestDetailVc.hidesBottomBarWhenPushed = YES;
        newestDetailVc.news = self.newsList[indexPath.row];
        //push 最新 详情控制器
        [self.parentViewController.navigationController pushViewController:newestDetailVc animated:YES];
    }
    
    if ([_channel.name isEqualToString:@"快报"]){
        
        AHBulletinDetailController *detailVc = [[AHBulletinDetailController alloc]init];
        detailVc.hidesBottomBarWhenPushed = YES;
        [self presentViewController:detailVc animated:YES completion:nil];
    }
    if ([_channel.name isEqualToString:@"新闻"] ||[_channel.name isEqualToString:@"评测"] ||[_channel.name isEqualToString:@"导购"] ||[_channel.name isEqualToString:@"用车"] ||[_channel.name isEqualToString:@"技术"] ||[_channel.name isEqualToString:@"文化"]) {
        
        AHNewestDetailController *newestDetailVc = [[AHNewestDetailController alloc]init];
        
        newestDetailVc.isNewest = NO;
        newestDetailVc.isImageView = NO;

        newestDetailVc.hidesBottomBarWhenPushed = YES;
        newestDetailVc.news = self.newsList[indexPath .row];
        //push 最新 详情控制器
        [self.parentViewController.navigationController pushViewController:newestDetailVc animated:YES];
    }
}

#pragma  mark - lazy
-(NSCache *)cellCache
{

    if (!_cellCache) {
        _cellCache = [[NSCache alloc]init];
    }
    return _cellCache;
}
@end
