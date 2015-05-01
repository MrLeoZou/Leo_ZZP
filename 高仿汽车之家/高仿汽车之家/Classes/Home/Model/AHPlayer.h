//
//  AHPlayer.h
//  高仿汽车之家
//
//  Created by apple on 15/4/6.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHPlayer : NSObject
/*
 imgurl = http://www0.autoimg.cn/zx/newspic/2015/4/3/640x320_0_2015040316095273203.jpg;
	jumpurl = ;
	updatetime = 20150406065401;
	id = 34786;
	replycount = 0;
	title = 来自未来的车 试驾特斯拉MODEL S P85D;
	pageindex = 1;
	JumpType = 0;
	mediatype = 2;
	type = 原创;
 */
///  图片URL
@property(nonatomic,copy)NSString *imgurl;
///  更新时间
@property(nonatomic,copy)NSString *updatetime;
///  id
@property(nonatomic,assign)int id;
///  回复数
@property(nonatomic,assign)long replycount;
///  标题
@property(nonatomic,copy)NSString *title;
///  媒体类型 2
@property(nonatomic,assign)int mediatype;
///  标题类型 ，原创
@property(nonatomic,copy)NSString *type;

///传入字典转成play模型
+ (instancetype)playerWithDict:(NSDictionary *)dict;

///  根据 URL 下载新闻数据
+ (void)playersWithURLString:(NSString *)urlString complection:(void (^)(NSArray *players))complection;
@end
