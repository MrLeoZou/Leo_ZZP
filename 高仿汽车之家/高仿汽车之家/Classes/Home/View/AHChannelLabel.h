//
//  AHChannelLabel.h
//  高仿汽车之家
//
//  Created by apple on 15/4/4.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AHChannelLabel,AHChannel;
@protocol AHChannelLabelDelegate <NSObject>

///  代理方法，选中某个频道时调用
- (void)channelLabelDidSelected:(AHChannelLabel *)label;

@end

@interface AHChannelLabel : UILabel

///  代理
@property (nonatomic, weak) id<AHChannelLabelDelegate> delegate;
///  频道模型
@property (nonatomic, strong) AHChannel *channel;
///  缩放比例
@property (nonatomic, assign) CGFloat scale;

+ (instancetype)channelLabelWithTitle:(AHChannel *)channel;

@end
