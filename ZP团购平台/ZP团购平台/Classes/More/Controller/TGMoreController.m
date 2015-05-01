//
//  TGMoreController.m
//  东莞团购平台
//
//  Created by mac on 14-11-3.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGMoreController.h"
#import "GroupCell.h"
#import "ZPScanController.h"

@interface TGMoreController ()
{

    NSArray *_moreData;
}
@end

@implementation TGMoreController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.设置标题
    self.title = @"更多";
    
    //2.加载数据
    [self loadData];
    
    //3.设置tableView属性
    [self buildTableView];

}

-(void)loadData
{

    //1.获得路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"More" withExtension:@"plist"];
    
    //2.读取数据
    _moreData = [NSArray arrayWithContentsOfURL:url];
}

-(void)buildTableView
{

    // 1.设置背景
    // backgroundView的优先级 > backgroundColor
    self.tableView.backgroundView = nil;
    //    0~1
    self.tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    // 2.设置tableView每组头部的高度
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 0;
}

#pragma mark - tableView的数据源和代理方法
#pragma mark 返回有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _moreData.count;
}

#pragma mark 返回第section组有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = _moreData[section];
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
    NSDictionary *dict = _moreData[indexPath.section][indexPath.row];
    
    // 2.设置文字
    cell.textLabel.text = dict[@"name"];
    
    // 3.设置cell的背景
    cell.indexPath = indexPath;
    cell.backgroundColor = [UIColor clearColor];
    
    // 4.设置cell的类型（设置右边显示什么东西）
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.cellType = kCellTypeSwitch;
    }else if (indexPath.section == 0 && indexPath.row == 4){
        cell.cellType = kCellTypeLabel;
        cell.rightLabel.text = @"中字号（默认）";
    }else{
    cell.cellType = kCellTypeArrow;
    }
    return cell;
}

#pragma mark 设置每一组底部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _moreData.count - 1) {
        return 10;
    }
    return 0;
}

#pragma mark 设置每一组头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 30;
    
}

#pragma mark 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        //进入扫一扫界面控制器
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ZPScanController" bundle:nil];
        ZPScanController *scanVc = [sb instantiateInitialViewController];
        [self presentViewController:scanVc animated:YES completion:nil];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    if (section == 0) {
        return @"设置";
    }
    return @"其他";
}
@end
