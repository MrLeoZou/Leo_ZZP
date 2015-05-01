//
//  TGScanView.m
//  东莞团购平台
//
//  Created by mac on 14-12-30.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGScanView.h"

@implementation TGScanView

//-(void)loopDrawLine
//
//{
//    
//    CGRect  rect = CGRectMake(0, 50, 320, 2);
//    
//    if (readLineView) {
//        
//        [readLineView removeFromSuperview];
//        
//    }
//    
//    readLineView = [[UIImageView alloc] initWithFrame:rect];
//    
//    readLineView.backgroundColor = [UIColor redColor];
//    
//    [UIView animateWithDuration:3.0
//     
//                          delay: 0.0
//     
//                        options: UIViewAnimationOptionCurveEaseIn
//     
//                     animations:^{
//                         
//                         //修改fream的代码写在这里
//                         
//                         readLineView.frame =CGRectMake(0, 300, 320, 2);
//                         
//                         [readLineView setAnimationRepeatCount:0];
//                         
//                         
//                         
//                     }
//     
//                     completion:^(BOOL finished){
//                         
//                         if (!is_Anmotion) {
//                             
//                             [self loopDrawLine];
//                             
//                         }
//                         
//                         
//                         
//                     }];
//    
//    
//    
//    if (!is_have) {
//        
//        UIImage *hbImage=[UIImage imageNamed:@"DecodeFrameForeground.png"];
//        
//        UIImageView *hbImageview=[[UIImageView alloc] initWithImage:hbImage];
//        
//        //添加一个背景图片
//        
//        CGRect hbImagerect=CGRectMake(0, 0, 320, 435);
//        
//        [hbImageview setFrame:hbImagerect];
//        
//        
//        
//        ZBarReaderView  *readview = [ZBarReaderView new];
//        
//        readview.backgroundColor = [UIColor clearColor];
//        
//        readview.frame = CGRectMake(0, 0, 320, 380);
//        
//        readview.readerDelegate = self;
//        
//        readview.allowsPinchZoom = YES;//使用手势变焦
//        
//        readview.trackingColor = [UIColor redColor];
//        
//        readview.showsFPS = YES;// 显示帧率  YES 显示  NO 不显示
//        
//        readview.scanCrop = CGRectMake(0, 0, 1, 1);//将被扫描的图像的区域
//        
//        [readview addSubview:hbImageview];
//        
//        [readview addSubview:readLineView];
//        
//        [self.view addSubview:readview];
//        
//        [readview start];
//        
//        is_have = YES;
//        
//    }
//    
//    [self.view addSubview:readLineView];
//    
//}
////根据实际情况 自己设置参数  ，需要注意的是 扫描到数据后一定要记得：
//[readerView stop];
//
//[readerView removeFromSuperview];


@end
