//
//  AHContentCell.h
//  高仿汽车之家
//
//  Created by apple on 15/4/4.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHBaseContentController.h"

@class AHChannel;
@interface AHContentCell : UICollectionViewCell

/// 接收一个模型数据
@property(nonatomic,strong)AHChannel *channel;

///  定义一个AHContentController的对象属性，将内部创建好的内容VC提供给外界访问
@property(nonatomic,strong)AHBaseContentController *contentVc;


@end
