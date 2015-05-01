//
//  AHForumViewCell.h
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AHForum;
@interface AHForumViewCell : UITableViewCell

///  接收一个论坛模型数据
@property(nonatomic,strong)AHForum *forum;
@end
