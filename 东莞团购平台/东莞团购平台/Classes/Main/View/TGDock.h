//
//  TGDock.h
//  东莞团购平台
//
//  Created by mac on 14-11-2.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGDock;

@protocol DockDelegate <NSObject>
@optional
- (void)dock:(TGDock *)dock itemSelectedFrom:(int)from to:(int)to;
@end

@interface TGDock : UIView
// 添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title;

// 代理
@property (nonatomic, weak) id<DockDelegate> delegate;

@property (nonatomic, assign) int selectedIndex;
@end
