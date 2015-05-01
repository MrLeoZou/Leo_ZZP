//
//  AHForumCollectionCell.h
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHForumContentController.h"

@class AHForumChannel;
@interface AHForumCollectionCell : UICollectionViewCell


/// 接收一个模型数据
@property(nonatomic,strong)AHForumChannel *forumChannel;

///  定义一个AHContentController的对象属性，将内部创建好的VC提供给外界访问
@property(nonatomic,strong)AHForumContentController *contentVc;

@end
