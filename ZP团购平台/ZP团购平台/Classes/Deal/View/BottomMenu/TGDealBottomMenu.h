//
//  TGDealBottomMenu.h
//  东莞团购平台
//
//  Created by mac on 14-11-23.
//  Copyright (c) 2014年 tuangou. All rights reserved.

//底部菜单，父类，实现共有的属性

#import <UIKit/UIKit.h>

@class TGSubtitlesView,TGDealBottomMenuItem;
@interface TGDealBottomMenu : UIView
{
    ///开放出来给子类访问
    TGSubtitlesView *_subtitlesView;
    ///父类创建好的scrollView给子类使用，自由添加内容
    UIScrollView *_scrollView;
    ///item被选中标记
    TGDealBottomMenuItem *_selectedItem;
}

@property (nonatomic, copy) void (^hideBlock)();

/// 通过动画显示出来
- (void)show;
/// 通过动画隐藏
- (void)hide;


///父类声明一个方法，给子类实现，设置自己的子菜单标题，父类只负责调用
-(void)settingSubtitlesView;

@end