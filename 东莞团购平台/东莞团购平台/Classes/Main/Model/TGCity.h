//
//  TGCity.h
//  团购
//
//  Created by zhipeng on 14-8-6.
//  Copyright (c) 2014年 zou. All rights reserved.

//

#import "TGBaseModel.h"
#import <CoreLocation/CoreLocation.h>

@interface TGCity : TGBaseModel
@property(nonatomic,strong)NSArray *districts; //分区
@property(nonatomic,assign)BOOL hot;//城市热度
@property(nonatomic,assign) CLLocationCoordinate2D position;//当前城市的位置
@end
