//
//  UIBarButtonItem+ZP.m
//  东莞团购平台
//
//  Created by apple on 15/3/30.
//  Copyright (c) 2015年 tuangou. All rights reserved.
//

#import "UIBarButtonItem+ZP.h"

@implementation UIBarButtonItem (ZP)

- (id)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action
{
    // 创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置普通背景图片
    UIImage *image = [UIImage imageNamed:icon];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    
    // 设置高亮图片
    [btn setBackgroundImage:[UIImage imageNamed:highlighted] forState:UIControlStateSelected];
    
    // 设置尺寸
    btn.bounds = (CGRect){CGPointZero, image.size};
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:btn];
}

+ (id)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action
{
    return [[self alloc] initWithIcon:icon highlightedIcon:highlighted target:target action:action];
}


@end
