//
//  TGLeftBtn.h
//  东莞团购平台
//
//  Created by mac on 14-11-5.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGCity;
//设置一个城市改变的代理
@protocol LeftBtnDelegate <NSObject>
@optional
-(void)cityIsChange:(TGCity *)city;

@end

@interface TGLeftBtn : UIButton

//代理
@property(nonatomic,weak)id<LeftBtnDelegate> delegate;
@end
