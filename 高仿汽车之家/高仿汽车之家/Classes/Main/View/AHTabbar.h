//
//  AHTabbar.h
//  高仿汽车之家
//
//  Created by apple on 15/4/4.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AHTabbar;
@protocol AHTabbarDelegate <NSObject>

@optional
///  提供一个协议方法，将item选中信息传出去
- (void)tabbar:(AHTabbar *)tabbar didSelectedFrom:(NSInteger)from to:(NSInteger)to;

@end


@interface AHTabbar : UIView

///  代理属性
@property(nonatomic ,weak)id<AHTabbarDelegate> delegate;

///  动态添加子控制器item的方法
- (void)addOneItemWithContorllerItem:(UITabBarItem *)item;

@end
