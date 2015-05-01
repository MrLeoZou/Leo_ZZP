//
//  AHTabbar.m
//  高仿汽车之家
//
//  Created by apple on 15/4/4.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHTabbar.h"
#import "AHTabbarItem.h"

@interface AHTabbar ()
///  记录当前选中的btn
@property(nonatomic,strong)UIButton *selectedBtn;
@end

@implementation AHTabbar

-(void)addOneItemWithContorllerItem:(UITabBarItem *)item
{

    //添加按钮
    AHTabbarItem *btn = [AHTabbarItem buttonWithType: UIButtonTypeCustom];
    
    //设置按钮图片
    btn.imageView.contentMode = UIViewContentModeCenter;
    [btn setImage:item.image forState:UIControlStateNormal];
    [btn setImage:item.selectedImage forState:UIControlStateSelected];
    
    
    //绑定监听事件
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    //默认选择第一个
    if (0 == self.subviews.count) {
        [self btnClick:btn];
    }
    
    [self addSubview:btn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置frame
    CGFloat btnH = self.frame.size.height;
    CGFloat btnW = self.frame.size.width / self.subviews.count;
    CGFloat btnY = 0;
    for (int i = 0; i < self.subviews.count; i++) {
        
        CGFloat btnX = i * btnW;
        AHTabbarItem *btn = self.subviews[i];
        btn.tag = i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}

- (void)btnClick:(AHTabbarItem *)btn
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabbar:didSelectedFrom:to:)]) {
        [self.delegate tabbar:self didSelectedFrom:self.selectedBtn.tag to:btn.tag];
    }
    
    //控制选中状态
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}
@end
