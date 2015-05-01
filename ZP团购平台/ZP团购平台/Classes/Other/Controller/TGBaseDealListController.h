//
//  TGBaseDealListController.h
//  东莞团购平台
//
//  Created by mac on 14-12-28.
//  Copyright (c) 2014年 tuangou. All rights reserved.


//父类，用于展示团购列表控制器的公共属性

#import <UIKit/UIKit.h>

@interface TGBaseDealListController : UITableViewController

//父类提供一个数组，装着所有的团购数据，交给子类自己去实现，设置自身数据
-(NSArray *)totalDeals;
@end
