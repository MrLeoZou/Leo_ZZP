//
//  TGLocationTool.m
//  团购
//

#import "TGLocationTool.h"
#import "TGMetaDataTool.h"
#import "TGCity.h"

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
    }
    return self;
}


//更新用户位置
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 1.成功定位到一次，停止定位
    [_mgr stopUpdatingLocation];

    // 2.根据经纬度反向获得城市名称
    CLLocation *loc = locations[0];
    
    [_geo reverseGeocodeLocation:loc completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         CLPlacemark *place = placemarks[0]; //取得地标
         NSString *cityName = place.addressDictionary[@"City"]; //获得城市名
         cityName = [cityName substringToIndex:cityName.length - 1];  //去掉"市"字，（北京市）->(北京)
         TGCity *city = [TGMetaDataTool sharedTGMetaDataTool].totalCities[cityName]; //利用城市名从字典中取出对应的城市名
         [TGMetaDataTool sharedTGMetaDataTool].currentCity = city; //设置当前城市
         
         //设置定位城市
         _locationCity = city;
         //设置城市的位置
         _locationCity.position = loc.coordinate;

     }];
}

@end
