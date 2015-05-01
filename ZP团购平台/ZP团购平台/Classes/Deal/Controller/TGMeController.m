//
//  TGMeController.m
//  东莞团购平台
//
//  Created by mac on 14-11-16.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#pragma mark 这个类只用在MoreController
@interface LoginBtn : UIButton
@end

@implementation LoginBtn
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat width = contentRect.size.width - 2 * x;
    CGFloat height = contentRect.size.height;
    return CGRectMake(x, y, width, height);
}
@end

#import "TGMeController.h"
#import "UIImage+ZP.h"
#import "GroupCell.h"

@interface TGMeController ()
{

    NSArray *_data;
}
@end

@implementation TGMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置标题
    self.title = @"我的";
    
    //2.导航栏添加一个返回团购界面的按钮，并且移除meController
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bar_btn_icon_returntext"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    
    //3.添加"我的"界面
    self.delegate = self;
    
    //4.加载数据
    [self loadData];
    
    //5.设置tableView属性
    [self buildTableView];
}

#pragma mark 返回按钮的代理
-(void)backClick
{
    if ([_delegate respondsToSelector:@selector(backBtnClick:)]) {
        [_delegate backBtnClick:self];
    }
    
}

#pragma mark 加载数据
-(void)loadData
{

    //1.获得路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Me" withExtension:@"plist"];
    
    //2.读取数据
    _data = [NSArray arrayWithContentsOfURL:url];
    
}

#pragma mark 设置tableView属性
-(void)buildTableView
{
    // 1.设置背景
    // backgroundView的优先级 > backgroundColor
    self.tableView.backgroundView = nil;
    //    // 0~1
    self.tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    // 2.设置tableView每组头部的高度
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 0;
    
    //3.要在tableView顶部添加一个按钮
    LoginBtn *login = [LoginBtn buttonWithType:UIButtonTypeCustom];
    
    // 3.1 设置背景图片
    [login setImage:[UIImage resizedImage:@"common_button_login_red.png"] forState:UIControlStateNormal];
    [login setImage:[UIImage resizedImage:@"common_button_login_red_highlighted.png"] forState:UIControlStateHighlighted];
    
    // 3.2 tableHeaderView的宽度是不需要设置。默认就是整个tableView的宽度 90 176 167
    login.bounds = CGRectMake(0, 0, 0, 80);
    //3.3 增加顶部额外滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    // 3.4 设置按钮文字
    [login setTitle:@"点击登录   >>" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor colorWithRed:0/255.0 green:148/255.0 blue:250/255.0 alpha:1] forState:UIControlStateNormal];
    self.tableView.tableHeaderView = login;

    // 4.要在tableView底部添加一个按钮
    LoginBtn *logout = [LoginBtn buttonWithType:UIButtonTypeCustom];
    
    // 4.1 设置背景图片
    [logout setImage:[UIImage resizedImage:@"common_button_big_red.png"] forState:UIControlStateNormal];
    [logout setImage:[UIImage resizedImage:@"common_button_big_red_highlighted.png"] forState:UIControlStateHighlighted];
    
    // 4.2 tableFooterView的宽度是不需要设置。默认就是整个tableView的宽度
    logout.bounds = CGRectMake(0, 0, 0, 44);
    
    // 4.3 设置按钮文字
    [logout setTitle:@"取消登录" forState:UIControlStateNormal];
    self.tableView.tableFooterView = logout;
    
}

#pragma mark - tableView的数据源和代理方法
#pragma mark 返回有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return _data.count;
}

#pragma mark 返回第section组有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = _data[section];
    return array.count;
}

#pragma mark 返回每个cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    // forIndexPath:indexPath 跟 storyboard配套使用的
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[GroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        // 设置cell所在的tableView
        cell.myTableView = tableView;
    }
    
    // 1.取出这行对应的字典数据
    NSDictionary *dict = _data[indexPath.section][indexPath.row];
    
    // 2.设置文字
    cell.textLabel.text = dict[@"name"];
    
    // 3.设置cell的背景
    cell.indexPath = indexPath;
    cell.backgroundColor = [UIColor clearColor];
    
    // 4.设置cell的类型（设置右边显示什么东西）
    cell.cellType = kCellTypeArrow;
    return cell;
}

#pragma mark 设置每一组底部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _data.count - 1) {
        return 10;
    }
    return 0;
}

#pragma mark 设置每一组头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 10;
    
}

#pragma mark 取消选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
