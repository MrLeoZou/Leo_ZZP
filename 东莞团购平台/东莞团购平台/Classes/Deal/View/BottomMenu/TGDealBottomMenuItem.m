//
//  TGDealBottomMenuItem.m
//  东莞团购平台
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 tuangou. All rights reserved.

//所有底部菜单项的父类

#import "TGDealBottomMenuItem.h"
#import "UIImage+ZP.h"

@implementation TGDealBottomMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.右边的分割线
        UIImage *img = [UIImage imageNamed:@"separator_filter_item.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:img];
        divider.bounds = CGRectMake(0, 0, 2, kBottomMenuItemH * 0.7);
        divider.center = CGPointMake(kBottomMenuItemW, kBottomMenuItemH * 0.5);
        [self addSubview:divider];
        
        // 2.文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        // 3.设置被选中时的背景
        [self setBackgroundImage:[UIImage resizedImage:@"bg_filter_toggle_hl.png"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kBottomMenuItemW, kBottomMenuItemH);
    [super setFrame:frame];
}

- (void)setHighlighted:(BOOL)highlighted
{ }


- (NSArray *)titles
{
    return nil;
}

@end
