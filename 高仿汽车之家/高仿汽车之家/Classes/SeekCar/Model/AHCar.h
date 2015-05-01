//
//  AHSeekCar.h
//  高仿汽车之家
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHCar : NSObject

///  id
@property(nonatomic,assign)long id;

///  名字
@property(nonatomic,copy)NSString *name;

///  图片url
@property(nonatomic,copy)NSString *imgurl;

///  待定，NULL
@property(nonatomic,copy)NSString *tmimg;

@end
