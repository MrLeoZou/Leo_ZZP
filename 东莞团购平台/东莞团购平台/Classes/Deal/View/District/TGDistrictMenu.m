//
//  TGDistrictMenu.m
//  东莞团购平台
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 tuangou. All rights reserved.

//区域的底部菜单，继承团购底部菜单（父类）

#import "TGDistrictMenu.h"
#import "TGDistrictMenuItem.h"
#import "TGMetaDataTool.h"
#import "TGCity.h"
#import "TGDistrict.h"
#import "TGSubtitlesView.h"

@interface TGDistrictMenu()
{

    NSMutableArray *_allMenuItem; //用来装所有的分区item
}
@end

@implementation TGDistrictMenu

-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        //0.初始化item数组
        _allMenuItem = [NSMutableArray array];
        
        //2.
        [self cityChange];
  
        //3.监听城市改变通知
        //如果展示团购时，突然改变城市，则需要做相关处理，更改顶部菜单分区
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
    }
    
    return  self;
}

#pragma mark 城市改变通知调用方法
-(void)cityChange
{

    //获取当前城市
    TGCity *city = [TGMetaDataTool sharedTGMetaDataTool].currentCity;
    
    //1.1 先添加"全部商区"
    NSMutableArray *district = [NSMutableArray array];
    TGDistrict *allDistrict = [[TGDistrict alloc]init];
    allDistrict.name = kAllDistrict;
    [district addObject:allDistrict];
    
    //2.添加其他商区
    [district addObjectsFromArray:city.districts];
    
    //3.遍历所有商区
    NSUInteger count = district.count;

    for (int i = 0; i < count; i++) {
        TGDistrictMenuItem *item = nil;
        if (i >= _allMenuItem.count) { //原来的item不够用，则再创建
            //创建item
            item = [[TGDistrictMenuItem alloc]init];
            
            //调用父类的item点击方法
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            
            //创建完就添加到item数组和scrollView中
            [_allMenuItem addObject:item];
            [_scrollView addSubview:item];
            
        }else{   //原来的item够用
        
            item = _allMenuItem[i];
        }
        item.hidden = NO;
        item.district = district[i];
        item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);

        
        if (i == 0) {
            //默认选择全部商区
            item.selected = YES;
            _selectedItem = item;
        }else{
        
            item.selected = NO;
        }
    }
    
    //隐藏多余的item
    for (NSUInteger i = count; i < _allMenuItem.count; i++) {
        TGDistrictMenuItem *item = _allMenuItem[i];
        item.hidden = YES;
    }
    
    //设置scrollView的滚动区域
    _scrollView.contentSize = CGSizeMake(kBottomMenuItemW * count, 0);
    
    //城市改变，隐藏底部菜单（分类，商区，排序） 
    [_subtitlesView hide];
}

//移除通知
-(void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 实现父类声明的方法，设置自己子菜单的标题
-(void)settingSubtitlesView
{
    //2.1 使用传进来的block中的title来设置自己title
    _subtitlesView.setTitleBlock = ^(NSString *title){
        
        [TGMetaDataTool sharedTGMetaDataTool].currentDistrict = title;
    };
    
    //2.2 使用block把当前子菜单标题传出去
    _subtitlesView.getTitleBlock = ^{
        
        return [TGMetaDataTool sharedTGMetaDataTool].currentDistrict;
    };
}
@end
