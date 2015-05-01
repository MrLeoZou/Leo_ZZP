//
//  TGDealController.m
//  东莞团购平台
//
//  Created by mac on 14-11-3.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGDealController.h"
#import "UIBarButtonItem+ZP.h"
#import "TGLeftBtn.h"
#import "TGMeController.h"
#import "TGCityListControllerViewController.h"
#import "TGDealTopMenu.h"
#import "DPAPI.h"
#import "TGMetaDataTool.h"  
#import "TGCity.h"
#import "TGDeal.h"
#import "NSObject+Value.h"
#import "TGDealCell.h"
#import "TGDealTool.h"
#import "MJRefresh.h"
#import "TGImageTool.h"
#import "TGDealDetailController.h"
#import "TGNavigationController.h"

@interface TGDealController ()<UISearchBarDelegate,meViewDelegate,LeftBtnDelegate,DPRequestDelegate,UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>
{
    TGLeftBtn *_left; //左上角按钮
    UIView *_cover; //城市列表使用的遮盖
    UIView *_dealListCover; //团购列表使用的遮盖

    TGCityListControllerViewController *_cities; //
    NSMutableArray *_deals;
    UITableView *_tableView;
    
    int _page; //页码
    MJRefreshFooterView *_footer; //
    MJRefreshHeaderView *_header;
}

@end

@implementation TGDealController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //0.设置背景色，标题
    self.view.backgroundColor = kGlobalBg;
    self.title = @"团购";
    
    
    //1.添加左上角的定位button
    [self addLeftBtn];

    //2.添加右上角的登录button
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_tabbar_mine.png" highlightedIcon:@"icon_tabbar_mine_selected.png" target:self action:@selector(rightItemClick)];
    
    //3.添加顶部菜单栏View
    TGDealTopMenu *topMenu = [[TGDealTopMenu alloc]init];
    topMenu.frame = CGRectMake(0, 0, self.view.frame.size.width, kTopMenuItemH);
    [self.view addSubview:topMenu];
    
    //3.1 设置顶部菜单的contentView
    topMenu.contentView = self.view;
    topMenu.contentView.userInteractionEnabled = YES;

    
    //4. 监听所有通知
    kAddAllNotes(dataChange)
    
    //5.添加团购列表的tableView
    [self addTableView];
    
    [self addListCover];
    //6. 注册xib
    [_tableView registerNib:[UINib nibWithNibName:@"TGDealCell" bundle:nil] forCellReuseIdentifier:@"deal"];
    
    //7.添加刷新控件
    [self addRefresh];
    
//    //强制调用工具类，默认选择"北京"
//    [TGMetaDataTool sharedTGMetaDataTool].currentCity = [TGMetaDataTool sharedTGMetaDataTool].totalCities[@"北京"];
}

- (void)addListCover
{
    _dealListCover = [[UIView alloc] init];
    _dealListCover.frame = _tableView.bounds;
    _dealListCover.backgroundColor = [UIColor clearColor];
    [_tableView addSubview:_dealListCover];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGFloat x = _dealListCover.frame.size.width * 0.5;
    CGFloat y = _dealListCover.frame.size.height * 0.35;
    indicator.center = CGPointMake(x, y);
    [_dealListCover addSubview:indicator];
    [indicator startAnimating];
}

#pragma mark 通知调用方法,刷新数据
-(void)dataChange
{
 
    //1.监听到通知改变，就进入刷新状态
    [_header beginRefreshing];
    
    //2.移除列表遮盖
    [_dealListCover removeFromSuperview];
    _dealListCover = nil;
    
}

#pragma mark 添加刷新数据
-(void)addRefresh
{

    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = _tableView;
    header.delegate = self;
    _header = header;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = _tableView;
    footer.delegate = self;
    _footer = footer;
}
                                
#pragma mark 刷新代理方法
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    BOOL isHeader = [refreshView isKindOfClass:[MJRefreshHeaderView class]];
    if (isHeader) { //下拉刷新，就重新加载第一页数据
        //主动清除图片缓存
        [TGImageTool clear];
        _page = 1;
        
    }else{  //上拉加载更多
    
        _page++; //页码加1
        
    }
    [[TGDealTool sharedTGDealTool] dealsWithPage:_page success:^(NSArray *deals , int totalCount) {
        if(isHeader){
        
            _deals = [NSMutableArray array];
        }
        //1.添加数据
        [_deals addObjectsFromArray:deals];
        
        //2.刷新表格
        [_tableView reloadData];
        
        //3.恢复刷新状态
        [refreshView endRefreshing];
        
        //4.根据当前数量与总数比较，判断是否需要隐藏
        _footer.hidden = totalCount <= _deals.count;
        
    } error:^(NSError *error){  //出错也移除刷新
        
        [refreshView endRefreshing];
    }];
}

#pragma mark 添加左上角的定位button
-(void)addLeftBtn
{
    //1.创建item
    _left = [TGLeftBtn buttonWithType:UIButtonTypeCustom];
    _left.delegate = self;
    //2.设置位置
    _left.frame = CGRectMake(0, 0, 0, 0);
    
    //3.绑定监听
    [_left addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_left];
}


#pragma mark 导航栏左按钮点击事件
-(void)leftItemClick:(UIButton *)btn
{
    //1.添加城市列表控制器
    TGCityListControllerViewController *cities = [[TGCityListControllerViewController alloc]init];
    [self addChildViewController:cities];
    [self.view addSubview:cities.view];
    _cities = cities;
    btn.selected = YES;
    btn.userInteractionEnabled = NO;
    
    //2.添加遮盖，蒙版
    if (_cover==nil) {
        _cover = [[UIView alloc]init];
        _cover.backgroundColor = [UIColor blackColor];
        //设置代理监听蒙板点击
        [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)]];
    }
    //每次聚焦都拿到tableView最新的frame进行设置
    _cover.frame = CGRectMake(0, kTableViewHeight + 40, self.view.frame.size.width, self.view.frame.size.height - kTableViewHeight - 40);
    [self.view addSubview:_cover];
    //设置动画效果
    _cover.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.7;
    }];
    
}

#pragma mark 监听点击蒙板
-(void)coverClick
{
    //1.移除蒙板,移除城市列表控制器
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.0;
    }completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        [_cities removeFromParentViewController];
        [_cities.view removeFromSuperview];
        _left.selected = NO;
        _left.userInteractionEnabled = YES;
    }];
}

#pragma mark 实现LeftBtn的代理方法
//城市改变时，移除蒙板,移除城市列表控制器
-(void)cityIsChange:(TGCity *)city
{
    [_cover removeFromSuperview];
    [_cities removeFromParentViewController];
    [_cities.view removeFromSuperview];
    _left.selected = NO;
    _left.userInteractionEnabled = YES;
}

#pragma mark 导航栏右按钮点击事件
-(void)rightItemClick
{
    //1.跳转到"我的"界面
    TGMeController *meController = [[TGMeController alloc]initWithStyle:UITableViewStyleGrouped];
    meController.view.frame = CGRectMake(0, 0, 320, 568);
    meController.delegate = self;
    
    //2.添加"我的"控制器
    [self.navigationController pushViewController:meController animated:YES];
    
}

#pragma mark 实现meController的代理方法
-(void)backBtnClick:(TGMeController *)meController
{
    //1.移除meController
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//移除通知
-(void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 添加tableView
-(void)addTableView
{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, kTopMenuItemH, self.view.frame.size.width, self.view.frame.size.height);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kGlobalBg;  
    [self.view addSubview:_tableView];
}

#pragma mark - tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _deals.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *ID = @"deal" ;
    //1.先拿到标记去缓冲池中找
    TGDealCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    //3.设置cell的属性
    cell.deal = _deals[indexPath.row];
    

    //设置每个cell之间的间距
//    UIView *view = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, 320, 10)];
//                    
//    view.backgroundColor = kGlobalBg;
//    [cell.contentView addSubview:view];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //显示详情控制器
    [self showDetailController: _deals[indexPath.row]];

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
    //4.包装包行控制器
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
@end
