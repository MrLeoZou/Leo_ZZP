//
//  TGInfoHeadView.m
//  东莞团购平台
//
//  Created by mac on 14-12-26.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGInfoHeadView.h"
#import "TGDeal.h"
#import "TGImageTool.h"
#import "NSDate+ZP.h"
#import "TGRestriction.h"

@implementation TGInfoHeadView

-(void)setDeal:(TGDeal *)deal
{

    _deal = deal;

    //0.先做一次判断，避免重复加载数据
    if (deal.restrictions) { //团购约束有值，有完整数据
    
        //1.是否支持退款
        _anyTimeRefund.enabled = deal.restrictions.is_refundable;
        _expireRefund.enabled = _anyTimeRefund.enabled;

    }else{ //没有完整数据
    
        //2.下载图片
        [TGImageTool downloadImage:deal.image_url placeholder:[UIImage imageNamed:@"placeholder_deal.png"] imageView:_image];
        
        // 3.设置剩余时间
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd"; // 2013-11-17
        // 2013-11-17
        NSDate *dealline = [fmt dateFromString:deal.purchase_deadline];
        // 2013-11-18 00:00:00
        dealline = [dealline dateByAddingTimeInterval:24 * 3600];
        // 2013-11-17 10:50
        NSDate *now = [NSDate date];
        
        //3.1 调用NSData封装的时间处理方法
        NSDateComponents *cmps = [now compare:dealline];
        
        NSString *timeStr = [NSString stringWithFormat:@"%ld天 %ld小时 %ld分", (long)cmps.day, (long)cmps.hour, (long)cmps.minute];
    
        [_time setTitle:timeStr forState:UIControlStateNormal];
    }
    
    //4.购买人数
    NSString *title = [NSString stringWithFormat:@"%d人已购买",deal.purchase_count];
    [_purchaseCount setTitle:title forState:UIControlStateNormal];

    
    //5.设置描述
    _desc.text = deal.desc;
    //5.1 描述的高度
    CGFloat descH = [deal.desc sizeWithFont:_desc.font constrainedToSize:CGSizeMake(_desc.frame.size.width, MAXFLOAT) lineBreakMode:_desc.lineBreakMode].height + 20 ;
    CGRect descF = _desc.frame;
    
    CGFloat descDeltaH = descH - descF.size.height;
    
    descF.size.height = descH;
    _desc.frame = descF;
    
    // 6.设置整体的高度
    CGRect selfF = self.bounds;
    selfF.size.height += descDeltaH;
    self.bounds = selfF;

}

//提供一个类方法，返回创建好的xib
+(id)infoHeadViewXib
{
    return [[NSBundle mainBundle]loadNibNamed:@"TGInfoHeadView" owner:nil options:nil][0];
    
}

//重写setframe方法，设置自己高度
-(void)setFrame:(CGRect)frame
{
    //1.不允许外面修改自身的高度
    frame.size.height = self.frame.size.height;
    [super setFrame:frame];
}


@end
