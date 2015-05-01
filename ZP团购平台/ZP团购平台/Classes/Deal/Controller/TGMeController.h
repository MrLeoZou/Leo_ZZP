//
//  TGMeController.h
//  东莞团购平台
//
//  Created by mac on 14-11-16.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TGMeController;
@protocol meViewDelegate <NSObject>
@optional
-(void)backBtnClick:(TGMeController *)meController;

@end

@interface TGMeController : UITableViewController

@property(nonatomic,strong)id<meViewDelegate> delegate;
@end
