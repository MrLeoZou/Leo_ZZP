//
//  TGDealBottomMenu.m
//  东莞团购平台
//
//  Created by mac on 14-11-23.
//  Copyright (c) 2014年 tuangou. All rights reserved.

//所有底部菜单的父类

#import "TGDealBottomMenu.h"
#import "TGDealBottomMenuItem.h"
#import "TGSubtitlesView.h"
#import "TGMetaDataTool.h"

#import "TGCategoryMenuItem.h"
#import "TGDistrictMenuItem.h"
#import "TGOrderMenuItem.h"


#define kCoverAlpha 0.4

@interface TGDealBottomMenu()
{
    UIView *_cover;
    
    UIView *_contentView; //包括所有下拉菜单（scrollView + subtitlesView）
}
@end

@implementation TGDealBottomMenu

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.添加遮盖
        UIView *cover = [[UIView alloc]init];
        cover.frame = CGRectMake(0, kBottomMenuItemH, 320, 568);
        cover.alpha = kCoverAlpha;
        cover.backgroundColor = [UIColor blackColor];
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
        [self addSubview:cover];
        _cover = cover;
        
        
        //2.内容View
        _contentView = [[UIView alloc]init];
        _contentView.frame = CGRectMake(0, 0, 320, kBottomMenuItemH);
//        _contentView.backgroundColor = [UIColor redColor];
        _contentView.userInteractionEnabled = YES;
        [self addSubview:_contentView];
        
        //3.添加scrollView
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = CGRectMake(0, 0, 320, kBottomMenuItemH);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.backgroundColor = [UIColor whiteColor];
        
        _scrollView = scrollView;
       [_contentView addSubview:_scrollView];
        self.userInteractionEnabled = YES;
    }
    return self;
}


#pragma mark 监听按钮点击事件(子类的item点击都调用父类的这个方法)
-(void)itemClick:(TGDealBottomMenuItem *)item
{
    //1.控制item的状态
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    
    //2.判断item是否有子分类
    if (item.titles.count) { //显示子分类菜单
     
        [self showSubtitlesView:item];
    }else{ //隐藏子分类
    
        [self hideSubtitlesView:item];
    }
    
}

#pragma mark 显示子标题
-(void)showSubtitlesView:(TGDealBottomMenuItem *)item
{
    //1.创建子菜单View
    if (_subtitlesView == nil) {
        _subtitlesView = [[TGSubtitlesView alloc]init];
        _subtitlesView.userInteractionEnabled = YES;
        
        //2.创建完子菜单View，再调用子类实现的方法，设置子类自己的title
        [self settingSubtitlesView];
    }
    
    //3.设置子标题的frame
    _subtitlesView.frame = CGRectMake(0,  kBottomMenuItemH, 320, _subtitlesView.frame.size.height);

    //设置子标题的bottomTitle
    _subtitlesView.bottomTitle = [item titleForState:UIControlStateNormal];
    
    //设置子标题的内容，文字
    _subtitlesView.titles = item.titles ;

    //4.每次都调用layoutSubviews重新计算_subtitlesView的frame
    [_subtitlesView layoutSubviews];
    
    //5.表示当前没有展示子分类，则用动画展示
    if (_subtitlesView.superview == nil) {
        [_subtitlesView show];
    }
    //6.插入子分类菜单
    [_contentView insertSubview:_subtitlesView belowSubview:_scrollView];
    
    //7.重新计算contentView的高度
    CGRect f = _contentView.frame;
    f.size.height = CGRectGetMaxY(_subtitlesView.frame);
    _contentView.frame = f;
}

#pragma mark 隐藏子标题
-(void)hideSubtitlesView:(TGDealBottomMenuItem *)item
{

    //1.调用hide方法隐藏
    [_subtitlesView hide];
    
    //2.调整contentView的高度
    CGRect f = _contentView.frame;
    f.size.height = kBottomMenuItemH ;
    _contentView.frame = f;
    
    //3.没有子菜单，隐藏底部菜单后，设置数据给当前选中
    NSString *title = [item titleForState:UIControlStateNormal];
    if ([item isKindOfClass:[TGCategoryMenuItem class]]) { //分类
        [TGMetaDataTool sharedTGMetaDataTool].currentCategory = title;
        
    }else if ([item isKindOfClass:[TGDistrictMenuItem class]]) { //商区
        [TGMetaDataTool sharedTGMetaDataTool].currentDistrict = title;
    }else{  //排序
    
        [TGMetaDataTool sharedTGMetaDataTool].currentOrder = [[TGMetaDataTool sharedTGMetaDataTool] orderWithName:title] ;
    }
    
}

#pragma mark 显示
- (void)show
{
    
    _contentView.transform = CGAffineTransformMakeTranslation(0, -kBottomMenuItemH);
 
    _contentView.alpha = 0;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDuration animations:^{
        // 1.scrollView从上面 -> 下面
           _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        
        // 2.遮盖（0 -> 0.4）
        _cover.alpha = kCoverAlpha;
    }];
}

#pragma mark 隐藏
- (void)hide
{
    if (_hideBlock) {
        _hideBlock();
    }
    
    [UIView animateWithDuration:kDuration animations:^{
        // 1.scrollView从下面 -> 上面
        _contentView.transform = CGAffineTransformIdentity;
        
        _contentView.alpha = 0;
        
        // 2.遮盖（0.4 -> 0）
        _cover.alpha = 0;
    } completion:^(BOOL finished) {
        // 从父控件中移除
        [self removeFromSuperview];
        
        // 恢复属性
//        _contentView.transform = CGAffineTransformMakeTranslation(0, kBottomMenuItemH);
        _contentView.alpha  = 1;
        _cover.alpha = kCoverAlpha;
        
    }];
}

@end
