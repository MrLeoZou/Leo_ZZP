//
//  TGDealTopMenu.m
//  东莞团购平台
//
//  Created by mac on 14-11-23.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGDealTopMenu.h"
#import "TGDealTopMenuItem.h"
#import "TGCategoryMenu.h"
#import "TGDistrictMenu.h"
#import "TGOrderMenu.h"
#import "TGMetaDataTool.h"
#import "TGOrder.h"

@interface TGDealTopMenu()
{

    TGDealTopMenuItem *_selectedItem; //选中的item
    TGDealBottomMenu *_showingMenu ; //当前正在展示的底部菜单
    
    TGCategoryMenu *_cMenu ; //分类菜单
    TGDistrictMenu *_dMenu ; //区域菜单
    TGOrderMenu *_oMenu ; //排序菜单
    
    TGDealTopMenuItem *_cItem; //分类按钮
    TGDealTopMenuItem *_dItem; //区域按钮
    TGDealTopMenuItem *_oItem; //排序按钮
}

@end

@implementation TGDealTopMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.全部分类
        _cItem = [self addMenuItem:kAllCategory index:0];
        
        // 2.全部商区
        _dItem = [self addMenuItem:kAllDistrict index:1];
        
        // 3.默认排序
        _oItem = [self addMenuItem:@"默认排序" index:2];
        
        // 4.监听子菜单发出的通知（城市、分类、商区、排序）改变
        kAddAllNotes(dataChange)

    }
    return self;
}

#pragma mark 通知调用方法
-(void)dataChange
{

    //1.取消选中
    _selectedItem.selected = NO;
    _selectedItem = nil;
    
    //2.分类标题
    NSString *cTitle = [TGMetaDataTool sharedTGMetaDataTool].currentCategory;
    if (cTitle) {
        _cItem.title = cTitle;
    }
    
    //3.商区标题
    NSString *dTitle = [TGMetaDataTool sharedTGMetaDataTool].currentDistrict;
    if (dTitle) {
        _dItem.title = dTitle;
    }

    //4.排序标题
    NSString *oTitle = [TGMetaDataTool sharedTGMetaDataTool].currentOrder.name;
    if (oTitle) {
        _oItem.title = oTitle;
    }
    
    //5.选择了子菜单并设置顶部菜单标题之后，就隐藏底部菜单
    [_showingMenu hide];
    _showingMenu = nil; 
}

#pragma mark 添加一个菜单项
- (TGDealTopMenuItem *)addMenuItem:(NSString *)title index:(int)index
{
    TGDealTopMenuItem *item = [[TGDealTopMenuItem alloc] init];
    item.title = title;
    item.tag = index;
    item.frame = CGRectMake(kTopMenuItemW * index, 0, 0, 0);
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
    
    return item;
}

#pragma mark 监听顶部item的点击
- (void)itemClick:(TGDealTopMenuItem *)item
{
    //0.没有选择城市，不允许点击顶部菜单
    if ([TGMetaDataTool sharedTGMetaDataTool].currentCity == nil)  return;
    
    // 1.控制选中状态
    _selectedItem.selected = NO;
    if (_selectedItem == item) { //表示重复点击同一个Item
        _selectedItem = nil;
        
        // 隐藏底部菜单
        [self hideBottomMenu];
        
    } else {  //点击了不同item
        item.selected = YES;
        _selectedItem = item;
        
        //显示底部菜单
        [self showBottomMenu:item];
                  
    }
}

#pragma mark 隐藏底部菜单
- (void)hideBottomMenu
{
    [_showingMenu hide];
    _showingMenu = nil;
}

#pragma mark 显示底部菜单
- (void)showBottomMenu:(TGDealTopMenuItem *)item
{
    // 是否需要执行动画（没有正在展示的菜单时，就需要执行动画）
    BOOL animted = _showingMenu == nil;
    
    // 移除当前正在显示的菜单
    [_showingMenu removeFromSuperview];
    
    // 显示底部菜单
    if (item.tag == 0) { // 分类
        if (_cMenu == nil) {
            _cMenu = [[TGCategoryMenu alloc]init];
        }
        _showingMenu = _cMenu;
    } else if (item.tag == 1) { // 区域
        if (_dMenu == nil) {
            _dMenu = [[TGDistrictMenu alloc]init];
        }
        _showingMenu = _dMenu;
    } else { // 排序
        if (_oMenu == nil) {
            _oMenu = [[TGOrderMenu alloc]init];
        }
        _showingMenu = _oMenu;
    }
    

    // 设置frame
    _showingMenu.frame = CGRectMake(0, kTopMenuItemH,_contentView.frame.size.width,_contentView.frame.size.height);

    // 设置block回调
    __unsafe_unretained TGDealTopMenu *menu = self;
    _showingMenu.hideBlock = ^{
        // 1.取消选中当前的item
        menu->_selectedItem.selected = NO;
        menu->_selectedItem = nil;
        
        // 2.清空正在显示的菜单
        menu->_showingMenu = nil;
        
    };
    
    // 添加即将要显示的菜单
    [_contentView addSubview:_showingMenu];
    
    // 执行菜单出现的动画
    if (animted) {
        [_showingMenu show];
    }
}

//移除通知
-(void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(320, kTopMenuItemH);
    [super setFrame:frame];
}

@end
