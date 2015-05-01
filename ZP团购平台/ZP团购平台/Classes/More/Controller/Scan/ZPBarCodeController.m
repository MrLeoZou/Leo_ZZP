//
//  ZPBarCodeController.m
//  ZZP微博
//
//  Created by apple on 15/4/9.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "ZPBarCodeController.h"
#import <AVFoundation/AVFoundation.h>
#import "TGWebViewController.h"

@interface ZPBarCodeController ()<AVCaptureMetadataOutputObjectsDelegate>
///  定时器
@property(nonatomic,strong)CADisplayLink *display;
///  冲击波高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;
///  扫码会话
@property(nonatomic,strong)AVCaptureSession *seesion;
///  记录是否扫码成功
@property(nonatomic,assign)BOOL isSuccess;
@end

@implementation ZPBarCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CADisplayLink *display = [CADisplayLink displayLinkWithTarget:self selector:@selector(start)];
    self.display = display;
 
    //开始扫码
    [self scanCode];
}

- (void)scanCode
{
    
    //1.获取输入设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.创建输入对象
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
    if (input == nil) { //获取不到输入设备，直接返回
        return;
    }
    //3.创建输出对象
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    //4.设置代理监听输出对象的数据输出
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //5.创建会话
    AVCaptureSession *seesion = [[AVCaptureSession alloc]init];
    self.seesion = seesion;
    //6.添加输入输出对象到会话中
    if ([seesion canAddInput:input]) {
        
        [seesion addInput:input];
    }
    if ([seesion canAddOutput:output]) {
        
        [seesion addOutput:output];
    }
    //7.告诉输出对象接受哪种类型的条码
    [output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,nil]];
    
    //8.创建预览图层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:seesion];
    layer.frame = self.view.layer.frame;
    [self.view.layer insertSublayer:layer atIndex:0];
    //9.开始扫描
    [seesion startRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
///  接收到输出数据时调用
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        
        self.isSuccess = YES;
        //停止扫描
        [self.seesion stopRunning];
        //移除冲击波,移除定时器
        [self.display removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        //弹出详情链接控制器
        TGWebViewController *webVc = [[TGWebViewController alloc]init];
        webVc.urlStr = [metadataObjects.lastObject stringValue];
//        [self.navigationController pushViewController:webVc animated:YES];
        NSString *result = [metadataObjects.lastObject stringValue];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"条码结果" message:result delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
    
        //取出数据
//        NSLog(@"%@",[metadataObjects.lastObject stringValue]);
    }else{
        
        self.isSuccess = NO;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    //开启定时器
    [self.display addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //关闭定时器
    if (!self.isSuccess) {
        
        [self.display removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)start
{
//    NSLog(@"条形码 -- %s",__func__);
    if (self.constraint.constant < -150) {
        self.constraint.constant = 150;
        return;
    }
    self.constraint.constant --;
}


///  退下扫码控制器
- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
