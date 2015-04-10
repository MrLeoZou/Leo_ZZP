//
//  TGDealCell.m
//  东莞团购平台
//
//  Created by mac on 14-12-24.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGDealCell.h"
#import "TGDeal.h"
#import "TGImageTool.h"
#import "NSString+ZP.h"

@implementation TGDealCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDeal:(TGDeal *)deal
{
    _deal = deal;
 _desc.text =
    // 1.设置描述
    _desc.text = deal.desc;
    
    // 2.下载图片
    [TGImageTool downloadImage:deal.image_url placeholder:[UIImage imageNamed:@"placeholder_deal.png"] imageView:_image];
    
    // 3.购买人数
    [_purchaseCount setTitle:[NSString stringWithFormat:@"%d", deal.purchase_count] forState:UIControlStateNormal];
    
    // 4.价格,直接get方法获取TGDeal里面设置好的字符串
    _price.text = deal.current_price_text;

    // 5.标签
    NSDateFormatter *ftm = [[NSDateFormatter alloc]init];
    ftm.dateFormat = @"yyyy-MM-dd";
    NSString *nowData = [ftm stringFromDate:[NSDate date]];
    //判断
    if ([deal.publish_date isEqualToString:nowData]) { //今日新单
        _badge.hidden = NO;
        _badge.image = [UIImage imageNamed:@"ic_deal_new.png"];
    }else if ([deal.purchase_deadline isEqualToString:nowData]){ //即将过期
    
        _badge.hidden = NO;
        _badge.image = [UIImage imageNamed:@"ic_deal_soonOver.png"];
    }else if([deal.purchase_deadline compare:nowData] == NSOrderedAscending){ //已过期
    
        _badge.hidden = NO;
        _badge.image = [UIImage imageNamed:@"ic_deal_over.png"];
    }else{      //其他
    
        _badge.hidden = YES;
    }

}


@end
