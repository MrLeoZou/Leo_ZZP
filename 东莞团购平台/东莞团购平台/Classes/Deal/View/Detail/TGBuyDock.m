//
//  TGBuyDock.m
//  东莞团购平台
//
//  Created by mac on 14-12-25.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGBuyDock.h"
#import "TGDeal.h"
#import "TGLineLable.h"
#import "UIImage+ZP.h"

@implementation TGBuyDock

-(void)setDeal:(TGDeal *)deal
{

    _deal = deal;
    //
    _listPrice.text = [NSString stringWithFormat:@"%@元",deal.list_price_text];
    _currentPrice.text =  [NSString stringWithFormat:@"%@元",deal.current_price_text];
}

+(id)buyDockXib
{

    return [[NSBundle mainBundle]loadNibNamed:@"TGBuyDock" owner:nil options:nil][0];
}

//设置半透明的背景色
- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"bg_buyBtn.png"] drawInRect:rect];
}

#pragma mark 监听购买按钮点击
- (IBAction)buyNow
{
    NSString *ID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
    NSString *url = [NSString stringWithFormat:@"http://o.p.dianping.com/buy/d%@", ID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

}
@end
