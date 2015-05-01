//
//  TGInfoHeadView.h
//  东莞团购平台
//
//  Created by mac on 14-12-26.
//  Copyright (c) 2014年 tuangou. All rights reserved.

//团购简介，头部的xib View

#import "TGRoundRectView.h"
@class TGDeal;
@interface TGInfoHeadView : TGRoundRectView

@property(nonatomic, strong)TGDeal *deal;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIButton *anyTimeRefund;
@property (weak, nonatomic) IBOutlet UIButton *expireRefund;
@property (weak, nonatomic) IBOutlet UIButton *time;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;

//提供一个类方法，返回创建好的xib
+(id)infoHeadViewXib;

@end
