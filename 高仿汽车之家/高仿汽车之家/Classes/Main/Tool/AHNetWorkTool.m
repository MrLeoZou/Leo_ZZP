//
//  AHNetWorkTool.m
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHNetWorkTool.h"

@implementation AHNetWorkTool

+ (instancetype)shareNetWorkTool
{

    static AHNetWorkTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        tool = [[self alloc]initWithBaseURL:nil sessionConfiguration:config];
        tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", nil];
        
    });
    return tool;
}

///  加载首页界面cell详情的方法
-(void)loadHomeDetailViewWithUrlStr:(NSString *)UrlStr success:(void (^)(id))successBlock failed:(void (^)(NSError *))failedBlock
{
    [self loadDateWithUrlStr:UrlStr success:successBlock failed:failedBlock];

}

///请求首页新闻列表数据
-(void)loadHomeListDataWithUrlStr:(NSString *)UrlStr success:(void (^)(id))successBlock failed:(void (^)(NSError *))failedBlock
{
    [self loadDateWithUrlStr:UrlStr success:successBlock failed:failedBlock];
    
}

-(void)loadForumListDataWithUrlStr:(NSString *)UrlStr success:(void (^)(id))successBlock failed:(void (^)(NSError *))failedBlock
{

    [self loadDateWithUrlStr:UrlStr success:successBlock failed:failedBlock];
    
}

#pragma mark 内部封装请求数据方法
- (void)loadDateWithUrlStr:(NSString *)UrlStr success:(void (^)(id))successBlock failed:(void (^)(NSError *))failedBlock
{
    //先检测网络连接状态
    [[AHNetWorkCheck shareCheck] checkNetConnect];
    if (![AHNetWorkCheck shareCheck].isConnected) { //没有联网，直接不发送请求
        
        return;
    }
    
    [[AHNetWorkTool shareNetWorkTool] GET:UrlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (successBlock != nil) {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failedBlock != nil) {
            
            failedBlock(error);
        }
    }];
}
@end
