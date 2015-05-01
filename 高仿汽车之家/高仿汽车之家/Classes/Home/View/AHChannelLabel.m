//
//  AHChannelLabel.m
//  高仿汽车之家
//
//  Created by apple on 15/4/4.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHChannelLabel.h"
#import "AHChannel.h"

@implementation AHChannelLabel


#define NormalSize      14.0f
#define SelectedSize    20.0f

+ (instancetype)channelLabelWithTitle:(AHChannel *)channel {
    
    AHChannelLabel *l = [[self alloc] init];
    
    [l setUserInteractionEnabled:YES];
    // 设置大的字体
    l.font = [UIFont systemFontOfSize:SelectedSize];
    l.textAlignment = NSTextAlignmentCenter;
    l.textColor = [UIColor blackColor];
    
    l.channel = channel;
    l.text = channel.name;
    
    [l sizeToFit];
    
    // 修改成默认字体
    l.font = [UIFont systemFontOfSize:NormalSize];
    
    return l;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate channelLabelDidSelected:self];
}

- (void)setScale:(CGFloat)scale {
    CGFloat max = (SelectedSize / NormalSize) - 1;
    CGFloat percent = max * scale + 1;
    
    self.transform = CGAffineTransformMakeScale(percent, percent);
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
}



@end
