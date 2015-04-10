//
//  TGDetailDock.h
//  东莞团购平台
//
//  Created by mac on 14-12-25.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGDetailDockItem, TGDetailDock;

// 协议
@protocol TGDetailDockDelegate <NSObject>

@optional
- (void)detailDock:(TGDetailDock *)detailDock btnClickFrom:(int)from to:(int)to;
@end

//TGDetailDock类
@interface TGDetailDock : UIView

@property (weak, nonatomic) IBOutlet UIButton *infoBtn;

@property (nonatomic, weak) id<TGDetailDockDelegate> delegate;

//提供一个类方法，返回创建好的xib
+(id)detailDockXib;

- (IBAction)btnClick:(UIButton *)sender;

@end

//自己定义一个按钮类，覆盖掉默认的高亮状态
@interface TGDetailDockItem : UIButton
@end