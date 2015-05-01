//
//  TGDealCell.h
//  东莞团购平台
//
//  Created by mac on 14-12-24.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGDeal;
@interface TGDealCell : UITableViewCell

// 描述
@property (weak, nonatomic) IBOutlet UILabel *desc;
// 图片
@property (weak, nonatomic) IBOutlet UIImageView *image;
// 价格
@property (weak, nonatomic) IBOutlet UILabel *price;
// 购买人数
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;
// 标签
@property (weak, nonatomic) IBOutlet UIImageView *badge;

@property(nonatomic, strong) TGDeal *deal;
@end
