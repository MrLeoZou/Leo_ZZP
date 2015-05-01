//
//  AHForum.h
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHForum : NSObject
///  主题的id ；39976643
@property(nonatomic,assign)long topicid;
///  标题；成功说服家人 标致408 1.8L购车记
@property(nonatomic,copy)NSString *title;
///  发布时间；5分钟前
@property(nonatomic,copy)NSString *lastreplydate;
///  作者名
@property(nonatomic,copy)NSString *postusername;
///  回复数
@property(nonatomic,assign)int replycounts;
///  图片URL
#warning 点击全部的时候，图片URL不可用。！
//http://club0.autoimg.cn/album/images/2015/04/05/240180_d432d671-cf14-46bc-ae62-eede8b1aaa99.jpg
@property(nonatomic,copy)NSString *smallpic;
///  查看数量
@property(nonatomic,assign)long views;
///  bbsid
@property(nonatomic,assign) int bbsid;
///  bbs类型; c
@property(nonatomic,copy)NSString *bbstype;
///  bbs名; 精挑细选2944季
@property(nonatomic,copy)NSString *bbsname;


///  根据 id内部生成URL 并下载论坛数据
+ (void)forumListWithURLString:(int)valueID complection:(void (^)(NSArray *forumList))complection;

///  传入字典，快速创建forum模型
+ (instancetype)forumsWithDict:(NSDictionary *)dict;
@end
