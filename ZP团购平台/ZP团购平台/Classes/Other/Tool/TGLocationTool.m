//
//  TGLocationTool.m
//  团购
//

#import "TGLocationTool.h"
#import "TGMetaDataTool.h"
#import "TGCity.h"
#import "SVProgressHUD.h"

@interface TGLocationTool() <CLLocationManagerDelegate>
{
     CLLocationManager *_mgr;
     CLGeocoder *_geo;
}
@end

@implementation TGLocationTool
single_implementation(TGLocationTool)

- (id)init
{
    if (self = [super init]) {
        _geo = [[CLGeocoder alloc] init];
        
        _mgr = [[CLLocationManager alloc] init];
        _mgr.delegate = self;
        [_mgr startUpdatingLocation];
        
        //如果5秒内定位不成功，不一定失败，提示用户手动选择城市
        NSTimer *timer = [NSTimer timerWithTimeInterval:8.0 target:self selector:@selector(tipUserInputCity) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    return self;
}


//更新用户位置
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%s",__func__);
    
    // 1.成功定位到一次，停止定位
    [_mgr stopUpdatingLocation];

    // 2.根据经纬度反向获得城市名称
    CLLocation *loc = locations[0];
    
    [_geo reverseGeocodeLocation:loc completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         CLPlacemark *place = placemarks[0]; //取得地标
//         NSString *cityName = place.addressDictionary[@"City"]; //获得城市名
         NSString *cityName = place.addressDictionary[@"State"];
         cityName = [cityName substringToIndex:cityName.length - 1];  //去掉"市"字，（北京市）->(北京)
         TGCity *city = [TGMetaDataTool sharedTGMetaDataTool].totalCities[cityName]; //利用城市名从字典中取出对应的城市名
         if (city != nil) {
             
             [TGMetaDataTool sharedTGMetaDataTool].currentCity = city; //设置当前城市
         }
         
         //设置定位城市
         _locationCity = city;
         //设置城市的位置
         _locationCity.position = loc.coordinate;

     }];
}

- (void)tipUserInputCity
{
    if (self.locationCity == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位失败，请手动选择城市" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alert show];
    }
}

@end
