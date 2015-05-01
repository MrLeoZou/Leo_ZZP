//
//  TGBuyDock.h
//  东莞团购平台
//
//  Created by mac on 14-12-25.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGDeal,TGLineLable;
@interface TGBuyDock : UIView
@property (weak, nonatomic) IBOutlet TGLineLable *listPrice;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
//点击立即购买按钮
- (IBAction)buyNow;

//提供一个类方法，返回创建好的xib
+(id)buyDockXib;

@property(nonatomic,strong)TGDeal *deal;

@end
