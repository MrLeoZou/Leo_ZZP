//
//  TGMapController.m
//  东莞团购平台
//
//  Created by mac on 14-11-3.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGMapController.h"
#import <MapKit/MapKit.h>
#import "TGDealPosAnnotation.h"
#import "TGDealTool.h"
#import "TGBusiness.h"
#import "TGDeal.h"
#import "TGDealDetailController.h"
#import "UIBarButtonItem+ZP.h"
#import "TGDeal.h"
#import "TGNavigationController.h"

#define kSpan MKCoordinateSpanMake(0.012404, 0.016468)

@interface TGMapController ()<MKMapViewDelegate,CLLocationManagerDelegate>
{

    MKMapView *_mapView;
    CLLocationManager *_locationManager;
     NSMutableArray *_showingDeals; //存放显示过的团购
}
@end

@implementation TGMapController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"地图";
    
    
    //1.创建地图
    MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];

//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
//    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [locationManager requestWhenInUseAuthorization];
//    }
//    [locationManager startUpdatingLocation];
    
   
    //2. 显示用户位置
    mapView.showsUserLocation = YES;
    mapView.mapType = MKMapTypeStandard;
    mapView.delegate = self;
    [mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [self.view addSubview:mapView];
    
    //3.初始化数组
    _showingDeals = [NSMutableArray array];
    
    //4.回到用户位置
    UIButton *backUser = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backUser setBackgroundImage:[UIImage imageNamed:@"btn_map_locate.png"] forState:UIControlStateNormal];
    [backUser setBackgroundImage:[UIImage imageNamed:@"btn_map_locate_hl.png"] forState:UIControlStateNormal];
    backUser.frame = CGRectMake(270, 400, 40, 40);
    [backUser addTarget:self action:@selector(backUserClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backUser];
}

#pragma mark 返回用户当前位置
-(void)backUserClick
{
    //1.中心点
    CLLocationCoordinate2D center = _mapView.userLocation.coordinate;
    //2.跨度（范围）
    MKCoordinateSpan span = kSpan;
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    //3.设置区域
    [_mapView setRegion:region animated:YES];
}

#pragma mark - mapView的代理方法
#pragma mark 当用户位置更新的时候就会调用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    if (_mapView) return;
    
    //1.位置（中心点）
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    
    //2.跨度（范围）
    MKCoordinateSpan span = kSpan;
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    //3.区域
    [mapView setRegion:region animated:YES];

    _mapView = mapView;
}

//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    if ([CLLocationManager locationServicesEnabled] &&
//        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
//         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
//            //定位功能可用，开始定位
//            _locationManager = [[CLLocationManager alloc] init];
//            _locationManager.delegate = self;
//            [_locationManager startUpdatingLocation];
//        }
//    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
//        
//        NSString *message = @"您的手机目前并未开启定位服务，如欲开启定位服务，请至设置->隐私->定位服务，开启本程序的定位功能";
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法定位" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
//
//    }

//    if (
//        
//        (![_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] && status != kCLAuthorizationStatusNotDetermined && status != kCLAuthorizationStatusRestricted&& status != kCLAuthorizationStatusRestricted)
//        ) {
//        
//        NSString *message = @"您的手机目前并未开启定位服务，如欲开启定位服务，请至设置->隐私->定位服务，开启本程序的定位功能";
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法定位" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
//        
//    }else {
//        
//        [_locationManager startUpdatingLocation];
//    }
//}

#pragma mark 拖动地图（地图展示的区域改变了）就会调用
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D pos = mapView.region.center;
    
    // 1.地图当前展示区域的中心位置
    [[TGDealTool sharedTGDealTool] dealWithPos:pos success:^(NSArray *deals, int totalCount) {
        for (TGDeal *d in deals) { //遍历所有团购
            // 已经显示过
            if ([_showingDeals containsObject:d]) continue;
            
            // 从未显示过
            [_showingDeals addObject:d];
            
            for (TGBusiness *b in d.businesses) { //遍历所有团购的商家信息
                //创建大头针
                TGDealPosAnnotation *anno = [[TGDealPosAnnotation alloc] init];
                anno.business = b;
                anno.deal = d;
                //设置大头针位置
                anno.coordinate = CLLocationCoordinate2DMake(b.latitude, b.longitude);
                [mapView addAnnotation:anno];
            }
        }
    } error:nil];
}

#pragma mark 返回每一个大头针长什么样
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(TGDealPosAnnotation *)annotation
{
    //如果是系统自带的大头针View，直接返回
    if (![annotation isKindOfClass:[TGDealPosAnnotation class]]) return nil;
    
    // 1.从缓存池中取出大头针view
    static NSString *ID = @"MKAnnotationView";
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    
    // 2.缓存池没有可循环利用的大头针view
    if (annoView == nil) {
        // 这里应该用MKPinAnnotationView这个子类
        annoView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
    }
    
    // 3.设置view的大头针信息
    annoView.annotation = annotation;
    
    // 4.设置图片
    annoView.image = [UIImage imageNamed:annotation.icon];
    
    return annoView;
}

#pragma mark 点击了大头针
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    // 1.展示详情
    TGDealPosAnnotation *anno = view.annotation;
    [self showDetailController:anno.deal];
    
    // 2.让选中的大头针居中
    [mapView setCenterCoordinate:anno.coordinate animated:YES];
    
    // 3.让view周边产生一些阴影效果
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 15;
}

//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    if (_mapView) return;
//    
//    //1.位置（中心点）
//    CLLocation *newLocation = locations.lastObject;
//    CLLocationCoordinate2D center = newLocation.coordinate;
//    
//    //2.跨度（范围）
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.0094, 0.0015);
//    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
//    
//    //3.区域
//    [_mapView setRegion:region animated:YES];
//    
//}

#pragma mark 显示详情控制器
-(void)showDetailController:(TGDeal *)deal
{
    //1.创建控制器
    TGDealDetailController *detail = [[TGDealDetailController alloc]init];
    
    //2.创建导航栏左上角按钮
    detail.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"btn_nav_close.png" highlightedIcon:@"btn_nav_close_hl.png" target:self action:@selector(hideDetailController)];
    
    //3.设置数据
    detail.deal = deal;
    
    //4.包装详情控制器
    TGNavigationController *nav = [[TGNavigationController alloc]initWithRootViewController:detail];
    nav.view.frame = CGRectMake(320, 0, 320, 568 - kDockHeight);
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    
    //5.使用动画展示
    [UIView animateWithDuration:kDuration animations:^{
        CGRect f = nav.view.frame;
        f.origin.x -= 320;
        nav.view.frame = f;
    }];
}

#pragma mark 隐藏详情控制器
-(void)hideDetailController
{
    //1.获得当前导航控制器
    UIViewController *nav = [self.navigationController.childViewControllers lastObject];
    
    //2.移除导航控制器
    [UIView animateWithDuration:kDuration animations:^{
        CGRect f = nav.view.frame;
        f.origin.x += 320;
        nav.view.frame = f;
    }completion:^(BOOL finished) {
        [nav removeFromParentViewController];
        [nav.view removeFromSuperview];
    }];
    
}

@end
