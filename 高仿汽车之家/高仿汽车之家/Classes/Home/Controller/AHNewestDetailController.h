//
//  AHNewestDetailController.h
//  高仿汽车之家
//
//  Created by apple on 15/4/18.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AHNews;
@interface AHNewestDetailController : UIViewController

///  接收外界传入的模型
@property(nonatomic,strong)AHNews *news;

///  提供一个BOOL属性，判断是否选中最新 --》头条，这行cell
@property(nonatomic,assign,getter=isTop)BOOL isTop;

///  提供一个属性，判断选中的是否最新界面
@property(nonatomic,assign,getter=isNewest)BOOL isNewest;

///  提供一个属性，判断选中的是否图片轮播器
@property(nonatomic,assign,getter=isImageView)BOOL isImageView;

///  接收外界传入的图片轮播器被点击图片的URL
@property(nonatomic,copy)NSString *imgVUrlStr;

@end
