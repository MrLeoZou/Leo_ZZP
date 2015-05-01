//
//  AHNews.h
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHNews : NSObject


//*********************************** 普通界面 ************************************//
/*  mediatype
 1:评论
 2：说客+评论
 3：播放
 4：
 5：回帖
 6：多图，显示三张
 */
///  回复类型
@property(nonatomic,assign) int mediatype;
///  所属的分类，可能为空
@property(nonatomic,copy)NSString *type;
///  标题
@property (nonatomic, copy) NSString *title;
///  id
@property (nonatomic, copy) NSString *id;
///  时间，格式 2015-04-04
@property(nonatomic,copy)NSString *time;
///  回复数量
@property(nonatomic,assign) int replycount;
///  单张图片URL
@property (nonatomic, copy) NSString *smallpic;
///  多图，三张图片的URL
@property(nonatomic,copy)NSString *indexdetail;
///  点击跳转的url
@property(nonatomic,copy)NSString *jumpurl;

///  根据 URL 下载非"快报"界面的新闻数据
+ (void)newsListWithURLString:(NSString *)urlString isNewest:(BOOL)isNewest complection:(void (^)(NSArray *newsList))complection;

///  传入字典，快速创建news模型
+ (instancetype)newsWithDict:(NSDictionary *)dict;

//*********************************** 快报界面 ************************************//
//title，id两个属性共享
///  状态
@property(nonatomic,assign)int state;
///  查看数量
@property(nonatomic,assign)long reviewcount;
///  图片
@property(nonatomic,copy)NSString *img;
///  大图
@property(nonatomic,copy)NSString *bgimage;
///  类型id
@property(nonatomic,assign)int typeid;
///  类型名字
@property(nonatomic,copy)NSString *typename;
///  创建时间
@property(nonatomic,copy)NSString *createtime;


///  传入字典，快速创建news模型
+ (instancetype)bulletinsWithDict:(NSDictionary *)dict;

///  根据 URL 下载快报界面的新闻数据
+ (void)bulletinListWithURLString:(NSString *)urlString complection:(void (^)(NSArray *bulletinList))complection;
@end
