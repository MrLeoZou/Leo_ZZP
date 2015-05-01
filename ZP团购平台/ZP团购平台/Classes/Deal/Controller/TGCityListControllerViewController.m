//
//  TGCityListControllerViewController.m
//  东莞团购平台
//
//  Created by mac on 14-11-16.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGCityListControllerViewController.h"
#import "TGCity.h"
#import "TGCitySection.h"
#import "TGMetaDataTool.h"
#import "TGSearchResultController.h"



@interface TGCityListControllerViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{

    UISearchBar *_searchBar; //搜索框
    UIView *_cover; //蒙版
    NSMutableArray *_citySections; //存放城市组数据
    TGSearchResultController *_searchResult; //搜索结果
    UITableView *_tableView;//
    NSArray *_citiesData; //

}
@end

@implementation TGCityListControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //1.添加搜索框
    [self addSearchBar];
    
    //2.添加tableView
    [self addTableView];
    
    //3.加载数据
    [self addCitiesData];
 }

#pragma mark 添加搜索框
-(void)addSearchBar
{
    UISearchBar *citySearch = [[UISearchBar alloc]init];
    citySearch.frame = CGRectMake(0, 0, kTableViewWidth,kSearchBarHeight);
    citySearch.placeholder = @"请输入城市名称或拼音";
    citySearch.delegate = self;
    [self.view addSubview:citySearch];
    _searchBar = citySearch;
}

#pragma mark 添加tableView
-(void)addTableView
{

    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake(0, kSearchBarHeight, kTableViewWidth, kTableViewHeight);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

#pragma mark 添加所有城市数据
-(void)addCitiesData
{
    _citySections = [NSMutableArray array];
    NSArray *array = [TGMetaDataTool sharedTGMetaDataTool].totalCitySections;
    [_citySections addObjectsFromArray:array];
}


#pragma mark - 搜索框代理方法
#pragma mark 监听搜索框文字改变
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length==0) {
        //隐藏搜索栏
        [_searchResult.view removeFromSuperview];
    }else
    {
        //显示搜索栏
        if (_searchResult == nil) {
            _searchResult = [[TGSearchResultController alloc]init];
            //如果一个控制器在另一个控制器上面，两者最好是父子关系（他们之前的View也是父子关系）
            _searchResult.view.frame = _cover.frame;
            _searchResult.view.autoresizingMask = _cover.autoresizingMask;
            [self addChildViewController:_searchResult];
        }
        _searchResult.searchText = searchText;
        [self.view addSubview:_searchResult.view];
    }
}

#pragma mark 搜索框开始编辑（开始聚焦）
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //1.显示取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
    //2.显示遮盖（蒙板）
    if (_cover==nil) {
        _cover = [[UIView alloc]init];
        _cover.backgroundColor = [UIColor blackColor];
        //设置代理监听蒙板点击
        [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)]];
    }
    //每次聚焦都拿到tableView最新的frame进行设置
    _cover.frame = _tableView.frame;
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
    //1.移除取消按钮
    [_searchBar setShowsCancelButton:NO animated:YES ];
    //2.移除蒙板
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.0;
    }completion:^(BOOL finished) {
        [_cover removeFromSuperview];
    }];
    //3.退下键盘
    [_searchBar endEditing:YES];
}

//点击取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self coverClick];
}

//点击键盘完成按钮（焦点取消）
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self coverClick];
}


#pragma mark - 实现数据源方法
#pragma mark 共有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _citySections.count;
    
}

#pragma mark 第section组共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TGCitySection *s = _citySections[section];
    return s.cities.count;
}

#pragma mark 每当有一个cell进入视野范围内，就会调用，返回当前这行的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //0.用static修饰局部变量，只初始化一次
    static NSString *ID=@"Cell";
    
    //1.拿到一个标识，先去缓冲池中找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //2.如果缓冲池中没有，才需要传入一个标识创建新的cell
    if (cell == nil ) {
        //通过xib文件来加载cell
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    TGCitySection *s = _citySections[indexPath.section];
    TGCity *city = s.cities[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

#pragma mark 第section组的标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    TGCitySection *s = _citySections[section];
    return s.name;
}

#pragma mark 创建索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //KVC，会取出_citySections所有元素name属性的值，放到数组中返回
    return [_citySections valueForKey:@"name"];
}

#pragma mark - tableView代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TGCitySection *s = _citySections[indexPath.section];
    TGCity *city = s.cities[indexPath.row];
    
    [TGMetaDataTool sharedTGMetaDataTool].currentCity = city;
    
}

#pragma mark 设置tableView组头部高度和cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return kTableViewCellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return kTableViewHeadHeight;
}
@end
