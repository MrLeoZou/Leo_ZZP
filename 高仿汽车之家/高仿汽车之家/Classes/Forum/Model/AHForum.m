//
//  AHForum.m
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHForum.h"
#import "AHNetWorkTool.h"

@implementation AHForum

+ (void)forumListWithURLString:(int)valueID complection:(void (^)(NSArray *))complection {
    
    NSString *newUrl = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov4.6/club/jingxuantopic-a2-pm1-v4.6.6-c%zd-p1-s30.html",valueID];
//    NSLog(@"%@\n",newUrl);
    
    [[AHNetWorkTool shareNetWorkTool] loadForumListDataWithUrlStr:newUrl success:^(id responseObject) {
        
        NSArray *array = responseObject[@"result"][@"list"];
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        //        NSLog(@"%@",array);
        for (NSDictionary *dict in array) {
            //网络加载的字典数据，直接转成模型
            [arrayM addObject:[self forumsWithDict:dict]];
        }
        
        if (complection != nil) {
            complection(arrayM.copy);
        }

    } failed:^(NSError *error) {
        
        DDLogError(@"%@",error);
    }];
}

+ (instancetype)forumsWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    for (NSString *key in [self properties]) {
        if (dict[key] != nil) {
            [obj setValue:dict[key] forKey:key];
        }
    }
    
    return obj;
}


+ (NSArray *)properties {
    return @[@"topicid", @"title", @"lastreplydate", @"postusername",@"replycounts",@"smallpic",@"views",@"bbsid",@"bbstype",@"bbsname"];
}
@end
