//
//  AHNetWorkTool.h
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <AFHTTPSessionManager.h>

@interface AHNetWorkTool : AFHTTPSessionManager

///  单例类，全局访问入口
+ (instancetype)shareNetWorkTool;

///  加载首页界面cell详情的方法
- (void)loadHomeDetailViewWithUrlStr:(NSString *)UrlStr success:(void(^)(id responseObject))successBlock failed:(void(^)(NSError *error))failedBlock;

///  加载首页列表数据的方法
- (void)loadHomeListDataWithUrlStr:(NSString *)UrlStr success:(void(^)(id responseObject))successBlock failed:(void(^)(NSError *error))failedBlock;

///  加载论坛列表数据的方法
- (void)loadForumListDataWithUrlStr:(NSString *)UrlStr success:(void(^)(id responseObject))successBlock failed:(void(^)(NSError *error))failedBlock;
@end
