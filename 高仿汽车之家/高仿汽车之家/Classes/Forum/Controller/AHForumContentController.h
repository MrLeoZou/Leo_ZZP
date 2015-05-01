//
//  AHForumContentController.h
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AHForumChannel;
@interface AHForumContentController : UITableViewController

///  接收外界传入的频道模型
@property(nonatomic,strong)AHForumChannel *ForumChannel;
@end
