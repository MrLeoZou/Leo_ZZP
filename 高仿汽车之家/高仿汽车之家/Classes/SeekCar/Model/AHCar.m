//
//  AHSeekCar.m
//  高仿汽车之家
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHCar.h"

@implementation AHCar

-(NSString *)description
{

    return [NSString stringWithFormat:@"id=%ld,name=%@,imgurl=%@,tmimg=%@",self.id,self.name,self.imgurl,self.tmimg];
}

@end
