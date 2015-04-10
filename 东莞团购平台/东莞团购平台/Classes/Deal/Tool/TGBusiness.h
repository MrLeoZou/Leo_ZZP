
//商家信息（模型）

#import <Foundation/Foundation.h>

@interface TGBusiness : NSObject
@property (nonatomic, copy) NSString * city; //城市
@property (nonatomic, copy) NSString * h5_url; //URL
@property (nonatomic, assign) int ID; //id
@property (nonatomic, assign) double latitude; //经度
@property (nonatomic, assign) double longitude; //纬度
@property (nonatomic, copy) NSString *name; //名称
@end
