//
//  ZPVisitingCardController.m
//  ZZP微博
//
//  Created by apple on 15/4/9.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "ZPVisitingCardController.h"
#import <CoreImage/CoreImage.h>

@interface ZPVisitingCardController ()

///  头像
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property(nonatomic,assign)CGColorSpaceRef cs;
@property(nonatomic,assign)CGImageRef scaledImage;
@end

@implementation ZPVisitingCardController

/*
 （1）生成二维码
 1、导入coreImage，通过滤镜CIFilter生成
 2、创建滤镜对象
 3、还原滤镜初始化属性
 4、将需要生成二维码的字符串转换成二进制数据
 5、给二维码滤镜设置数据
 6、获取滤镜生成的图片
 7、设置图片到控件
 （2）处理生成的CIImage，使用自定义方法，生成指定大小的UIImage
 
 2、在二维码上，添加头像
 （1）使用二维码图片加上头像，生成新的图片
 （2）使用位图绘制

 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //还原滤镜初始化属性
    [filter setDefaults];
    //将需要生成二维码的字符串转换成二进制数据
    NSString *str = @"我是测试数据";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    //给二维码滤镜设置数据
    [filter setValue:data forKeyPath:@"inputMessage"];
    //获取滤镜生成的图片
    CIImage *image = [filter outputImage];
    //根据CIImage生成指定大小的UIImage
    UIImage *newImg = [self createNonInterpolatedUIImageFormCIImage:image withSize:200];
    //添加个人头像到二维码图片上面
    UIImage *iconImage = [UIImage imageNamed:@"icon.png"];
    self.icon.image = [self addIconPicture:iconImage bgImg:newImg];
}

///  生成一张新的图片
///
///  @param icon  头像图片
///  @param bgImg 背景图片
- (UIImage *)addIconPicture:(UIImage *)icon bgImg:(UIImage *)bgImg
{

    //1.开启图片上下文
    UIGraphicsBeginImageContext(self.view.frame.size);
    // 2.绘制背景
    [bgImg drawInRect:CGRectMake(0, 0, bgImg.size.width, bgImg.size.height)];
    
    // 3.绘制图标
    CGFloat iconW = 50;
    CGFloat iconH = 50;
    CGFloat iconX = (bgImg.size.width - iconW) * 0.5;
    CGFloat iconY = (bgImg.size.height - iconH) * 0.5;
    [icon drawInRect:CGRectMake(iconX, iconY, iconW, iconH)];
    
    // 4.取出绘制好的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 5.关闭上下文
    UIGraphicsEndImageContext();
    // 6.返回生成好得图片
    return newImage;
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    UIImage *endImage = [UIImage imageWithCGImage:scaledImage];
    CGColorSpaceRelease(cs);
    CGImageRelease(scaledImage);
    return endImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
