//
//  UIBarButtonItem+Extension.h
//  传智彩票
//
//  Created by apple on 15/3/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

///快速创建nav的导航栏按钮
- (UIBarButtonItem *)initWithNorImage:(NSString *)norimage higImage:(NSString *)higImage title:(NSString *)title titleColor:(UIColor *)color target:(id)target action:(SEL)action;

///快速创建nav的导航栏按钮
+ (instancetype)itemWithNorImage:(NSString *)norimage higImage:(NSString *)higImage title:(NSString *)title titleColor:(UIColor *)color target:(id)target action:(SEL)action;
@end
