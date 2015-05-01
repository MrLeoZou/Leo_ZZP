//
//  AHNews.m
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHNews.h"
#import "AHNetWorkTool.h"

@implementation AHNews

///请求普通新闻列表数据
+ (void)newsListWithURLString:(NSString *)urlString isNewest:(BOOL)isNewest complection:(void (^)(NSArray *))complection {
    
    [[AHNetWorkTool shareNetWorkTool] loadHomeListDataWithUrlStr:urlString success:^(id responseObject) {
        
        NSMutableArray *resultArr = [NSMutableArray array];
        NSArray *temp = responseObject[@"result"][@"newslist"];
        [resultArr addObjectsFromArray:temp];
        
        //        if (isNewest) { //如果是要加载最新界面的数据，需要插入一条topnewsinfo
        //            [resultArr insertObject:responseObject[@"result"][@"topnewsinfo"] atIndex:0];
        //        }
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:resultArr.count];
        
        for (NSDictionary *dict in resultArr) {
            //网络加载的字典数据，直接转成模型
            [arrayM addObject:[self newsWithDict:dict]];
        }
        
        if (complection != nil) {
            complection(arrayM.copy);
        }
    }failed:^(NSError *error) {
        
        DDLogError(@"%@",error);
    }];
}

+ (instancetype)newsWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    for (NSString *key in [self properties]) {
        if (dict[key] != nil) {
            [obj setValue:dict[key] forKey:key];
        }
    }
    
    return obj;
}


+ (NSArray *)properties {
    return @[@"mediatype", @"type", @"title", @"id",@"time",@"replycount",@"smallpic",@"indexdetail",@"jumpurl"];
}

//**************************** 快报 ***********************************//

///请求快报列表数据
+(void)bulletinListWithURLString:(NSString *)urlString complection:(void (^)(NSArray *))complection
{
    
    [[AHNetWorkTool shareNetWorkTool] loadHomeListDataWithUrlStr:urlString success:^(id responseObject) {
        
        NSArray *array = responseObject[@"result"][@"list"];
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        for (NSDictionary *dict in array) {
            //网络加载的字典数据，直接转成模型
            [arrayM addObject:[self bulletinsWithDict:dict]];
        }
        
        if (complection != nil) {
            complection(arrayM.copy);
        }

    } failed:^(NSError *error) {
        
        DDLogError(@"%@",error);
    }];
}

+(instancetype)bulletinsWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    
    for (NSString *key in [self bulletinProperties]) {
        if (dict[key] != nil) {
            [obj setValue:dict[key] forKey:key];
        }
    }
    
    return obj;
}

+ (NSArray *)bulletinProperties {
    return @[@"state", @"reviewcount", @"title", @"id",@"img",@"bgimage",@"typeid",@"typename",@"createtime"];
}


- (NSString *)description
{

    return [NSString stringWithFormat:@"title=%@,replycount=%zd",self.title,self.replycount];
}
@end
