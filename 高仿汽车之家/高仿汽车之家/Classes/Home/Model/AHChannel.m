//
//  AHChannel.m
//  高仿汽车之家
//
//  Created by apple on 15/4/4.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHChannel.h"

@implementation AHChannel

+ (instancetype)channelWithDict:(NSDictionary *)dict {
    
    AHChannel *channel = [[self alloc] init];
    
    [channel setValuesForKeysWithDictionary:dict];
    
    return channel;

}

+ (NSArray *)channel {
 
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Channels.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self channelWithDict:dict]];
    }
    
    return [arrayM sortedArrayUsingComparator:^NSComparisonResult(AHChannel *obj1, AHChannel *obj2) {
        return obj1.order > obj2.order;
    }];
}

-(NSString *)description
{

    return [NSString stringWithFormat:@"order = %@ ,url = %@ , name = %@",self.order,self.url ,self.name];
}
@end
