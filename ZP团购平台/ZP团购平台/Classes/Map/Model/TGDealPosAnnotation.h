
//大头针模型

#import <MapKit/MapKit.h>
@class TGDeal, TGBusiness;
@interface TGDealPosAnnotation : NSObject <MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) TGDeal *deal; // 显示的哪个团购
@property (nonatomic, strong) TGBusiness *business; // 显示的是哪个商家
@property (nonatomic, copy) NSString *icon; //大头针的图标





@end
