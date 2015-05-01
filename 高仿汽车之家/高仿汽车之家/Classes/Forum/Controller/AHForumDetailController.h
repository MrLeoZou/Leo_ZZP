//
//  AHDForumDetailController.h
//  高仿汽车之家
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AHForum;
@interface AHForumDetailController : UIViewController

///  接收外界传入的模型
@property(nonatomic,strong)AHForum *forum;
@end

