//
//  AHForumCollectionCell.m
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHForumCollectionCell.h"
#import "AHForumChannel.h"

@implementation AHForumCollectionCell

-(void)awakeFromNib
{
    // 通过storyBoard创建内容控制器
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AHForumContentVc" bundle:nil];
    AHForumContentController *contentVc = [sb instantiateInitialViewController];
    
    //设置控制器view的frame是cell的bounds
    contentVc.view.frame = self.bounds;
    
    //添加view到cell上
    [self addSubview:contentVc.view];
    
    self.contentVc = contentVc;
}

-(void)setForumChannel:(AHForumChannel *)forumChannel
{
    _forumChannel = forumChannel;
    
    //把当前item对应的模型传递给内容控制器
    self.contentVc.ForumChannel = forumChannel;
    
}

@end
