//
//  AHForumViewCell.m
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHForumViewCell.h"
#import "AHForum.h"
#import <UIImageView+AFNetworking.h>

@interface AHForumViewCell ()

///  头像
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
///  标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
///  时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
///  回帖数
@property (weak, nonatomic) IBOutlet UILabel *replayCount;
@end

@implementation AHForumViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 100;
}

-(void)setForum:(AHForum *)forum
{

    _forum = forum;
    
    //设置自定义cell内部子控件属性
    if (forum.smallpic != nil) {
        [self.iconView setImageWithURL:[NSURL URLWithString:forum.smallpic] placeholderImage:[UIImage imageNamed:@"img_nopic_day"]];
    }
    //标题
    self.titleLabel.text = forum.title;
    //类别的名称
    self.timeLabel.text = forum.bbsname;
    //回复数
    self.replayCount.text = [NSString stringWithFormat:@"%zd回",forum.replycounts];
}

@end
