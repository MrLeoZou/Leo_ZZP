//
//  TGSearchResultController.m
//  东莞团购平台
//
//  Created by mac on 14-11-22.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGSearchResultController.h"
#import "TGMetaDataTool.h"
#import "TGCity.h"
#import "PinYin4Objc.h"

@interface TGSearchResultController ()
{

    NSMutableArray *_totalResultCities; //所有搜索到城市
}
@end

@implementation TGSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    _totalResultCities = [NSMutableArray array];
}

#pragma mark 搜索框文字改变就刷新表格
-(void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    
    //清空之前的搜索结果
    [_totalResultCities removeAllObjects];
    
    //设置拼音格式
    HanyuPinyinOutputFormat *fmt = [[HanyuPinyinOutputFormat alloc]init];
    fmt.vCharType = VCharTypeWithUUnicode;
    fmt.caseType = CaseTypeUppercase;
    fmt.toneType = ToneTypeWithoutTone;
    

    //获取所有的城市的字典，key 是城市名  value 是城市对象
    NSDictionary *cities = [TGMetaDataTool sharedTGMetaDataTool].totalCities;
    //利用block遍历字典
    [cities enumerateKeysAndObjectsUsingBlock:^(NSString *key, TGCity *obj, BOOL *stop) {
        
        //获取城市名拼音
        NSString *pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:obj.name withHanyuPinyinOutputFormat:fmt withNSString:@"#"];
        
        //定义一个数组存放拼音头部
        NSMutableString *pinyinHeader = [NSMutableString string];
        //以#为分隔符截取字符串
        NSArray *words = [pinyin componentsSeparatedByString:@"#"];
        for (NSString *word in words) {
            [pinyinHeader appendString:[word substringToIndex:1]];
        }
        
        //去掉拼音中的#
       pinyin = [pinyin stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        //城市名中包含了搜索条件 ; 城市拼音中包含了搜索条件 ; 城市拼音首字母中包含了搜索条件
        if (([obj.name rangeOfString:searchText].length != 0) ||
            ([pinyin rangeOfString:searchText.uppercaseString].length != 0) ||
            ([pinyinHeader rangeOfString:searchText.uppercaseString].length != 0))
        {
            [_totalResultCities addObject:obj];
        }
    }];
    
    //刷新表格
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _totalResultCities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    TGCity *city = _totalResultCities[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    NSString *title = [NSString stringWithFormat:@"共有%ld个搜索结果",_totalResultCities.count];
    return title;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        TGCity *city = _totalResultCities[indexPath.row];
      [TGMetaDataTool sharedTGMetaDataTool].currentCity = city;
}
@end
