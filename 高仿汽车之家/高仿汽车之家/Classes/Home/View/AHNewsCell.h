//
//  AHNewsCell.h
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AHNews;
@interface AHNewsCell : UITableViewCell

///  接收新闻模型
@property (nonatomic, strong) AHNews *news;

///  根据模型属性，返回不同的cell标识
+ (NSString *)cellIdentifier:(AHNews *)news;

///  提供一个方法，接收模型，内部计算好行高返回
- (CGFloat)heigthForRowWithNews:(AHNews *)news;
@end
