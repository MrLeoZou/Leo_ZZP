//
//  AHContentCell.m
//  高仿汽车之家
//
//  Created by apple on 15/4/4.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHContentCell.h"

@interface AHContentCell()

@end

@implementation AHContentCell

-(void)awakeFromNib
{
    
    // 通过storyBoard创建内容控制器
    UIStoryboard *contentSb = [UIStoryboard storyboardWithName:@"AHBaseContentVc" bundle:nil];
    AHBaseContentController *contentVc = [contentSb instantiateInitialViewController];
    contentVc.view.frame = self.bounds;
    
    //添加view到cell上
    [self addSubview:contentVc.view];
    
    self.contentVc = contentVc;
}

-(void)setChannel:(AHChannel *)channel
{
    _channel = channel;
    
    //把当前item对应的模型传递给内容控制器
    self.contentVc.channel = channel;
}
@end
