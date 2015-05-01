//
//  AHNewsCell.m
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHNewsCell.h"
#import "AHNews.h"
#import <UIImageView+AFNetworking.h>

@interface AHNewsCell ()
///  头像
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
///  标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
///  时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
///  回帖数
@property (weak, nonatomic) IBOutlet UILabel *replayCount;
///  多图的时候，三张图片放在这个数组中
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViewArr;
///  说客
@property (weak, nonatomic) IBOutlet UILabel *talkLabel;

//**************************快报，大图 ***************************//
///  大图
@property (weak, nonatomic) IBOutlet UIImageView *bigImage;
///  结束播报
@property (weak, nonatomic) IBOutlet UILabel *endPlay;
///  大图的标题
@property (weak, nonatomic) IBOutlet UILabel *bigTitle;
///  大图的时间
@property (weak, nonatomic) IBOutlet UILabel *bigTime;
///  观众
@property (weak, nonatomic) IBOutlet UILabel *audience;

@end

@implementation AHNewsCell

+(NSString *)cellIdentifier:(AHNews *)news
{
    if (6 == news.mediatype) { //多图，显示三张图片
        return @"ImagesCell";
    }else if (news.img != nil){ //大图，快报的界面
//        NSLog(@"img == %@",news.img);
        return @"BigImageCell";
    }
    //否则返回常规cell
    return @"NewsCell";
}

- (CGFloat)heigthForRowWithNews:(AHNews *)news
{
    if (6 == news.mediatype) { //多图，显示三张图片
        return 120;
        
    }else if (news.img != nil){ //大图，快报的界面
        
        return 180;
    }
    //否则返回常规cell的高度
    
    return 80;
    
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 100;
}

-(void)setNews:(AHNews *)news
{

    _news = news;
    //设置属性
    self.talkLabel.hidden = YES;
    self.titleLabel.text = news.title;
    self.timeLabel.text = news.time;
    
    //设置回复类型
    NSString *temp = nil;
    switch (news.mediatype) {
        case 1: //评论
            temp = [NSString stringWithFormat:@"%zd评论",news.replycount];
            break;
        case 2://说客+评论
            self.talkLabel.hidden = NO;
            temp = [NSString stringWithFormat:@"%zd评论",news.replycount];
            break;
        case 3://播放
            temp = [NSString stringWithFormat:@"%zd播放",news.replycount];
            break;
        case 5://回帖
            temp = [NSString stringWithFormat:@"%zd回帖",news.replycount];
            break;
        case 6://图片
            temp = [NSString stringWithFormat:@"%zd图片",news.replycount];
            break;
        default://其他情况
            temp = [NSString stringWithFormat:@"%zd评论",news.replycount];
            break;
    }
    self.replayCount.text = temp;
    
    //设置单张图片头像
    if (news.smallpic != nil) {
        
        [self.iconView setImageWithURL:[NSURL URLWithString:news.smallpic] placeholderImage:[UIImage imageNamed:@"img_nopic_day"]];
    }
    
    //设置多图，三张图片
    /*
     890㊣22145㊣http://car0.autoimg.cn/car/upload/2015/4/2/t_201504022209355643655110.jpg,http://car0.autoimg.cn/car/upload/2015/4/2/t_201504022209322973655112.jpg,http://car0.autoimg.cn/car/upload/2015/4/2/t_201504022209294223655112.jpg
     */

    if (6 == news.mediatype) {
        NSString *str = news.indexdetail;
        
        //截取出三个URL
        NSMutableString *newStr = [NSMutableString string];
        for (int i =0; i <str.length; i++) {
            char c = [str characterAtIndex:i];
            if (c == 'h') {
                NSString *tempStr = [str substringFromIndex:i];
//                NSLog(@"temp ---> %@",tempStr);
                [newStr setString:tempStr];
//                NSLog(@"news -- > %@",newStr);
                break;
            }
        }
        NSArray *strArr = [newStr componentsSeparatedByString:@","];
//        NSString *url1 = strArr[0];
//        NSString *url2 = strArr[1];
//        NSString *url3 = strArr[2];
//        NSLog(@"%@ - %@ - %@",url1,url2,url3);
        for (int i = 0; i<strArr.count; i++) {
            UIImageView *imgV = self.imageViewArr[i];
            
            NSURL *url = [NSURL URLWithString:strArr[i]];
            [imgV setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img_nopic_day"]];
        }
    }
    
    //********************快报**********************************//
    if (news.bgimage != nil) {
        [self.bigImage setImageWithURL:[NSURL URLWithString:news.bgimage] placeholderImage:[UIImage imageNamed:@"default_640_320"]];

        self.bigTitle.text = news.title;
        self.bigTime.text = news.createtime;
        self.audience.text = [NSString stringWithFormat:@"%zd位观众",news.reviewcount];
    }
    
}
@end
