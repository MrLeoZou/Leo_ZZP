//
//  TGDock.m
//  东莞团购平台
//
//  Created by mac on 14-11-2.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGDock.h"
#import "TGDockItem.h"

@interface TGDock()
{
    TGDockItem *_selectedItem;
}
@end

@implementation TGDock

#pragma mark 添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title
{
    // 1.创建item
    TGDockItem *item = [[TGDockItem alloc] init];
    // 文字
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    // 图标
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    // 监听item的点击
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    
    // 2.添加item
    [self addSubview:item];
    NSUInteger count = self.subviews.count;
    // 默认选中第一个item
    if (count == 1) {
        [self itemClick:item];
    }
    
    // 3.调整所有item的frame
    CGFloat height = self.frame.size.height; // 高度
    CGFloat width = self.frame.size.width / count; // 宽度
    for (int i = 0; i<count; i++) {
        TGDockItem *dockItem = self.subviews[i];
        dockItem.tag = i; // 绑定标记
        dockItem.frame = CGRectMake(width * i, 0, width, height);
    }
}

#pragma mark 监听item点击
- (void)itemClick:(TGDockItem *)item
{
    // 0.通知代理
    if ([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)]) {
        [_delegate dock:self itemSelectedFrom:_selectedItem.tag to:item.tag];
    }
    
    // 1.取消选中当前选中的item
    _selectedItem.selected = NO;
    
    // 2.选中点击的item
    item.selected = YES;
    
    // 3.赋值
    _selectedItem = item;
    
    _selectedIndex = _selectedItem.tag;
}
@end
