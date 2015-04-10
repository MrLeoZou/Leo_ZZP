//
//  TGLocationTool.h
//定位功能，工具类

#import <Foundation/Foundation.h>
#import "Singleton.h"

#import <CoreLocation/CoreLocation.h>
@class TGCity;
@interface TGLocationTool : NSObject
single_interface(TGLocationTool)

@property (nonatomic, strong) TGCity *locationCity; // 定位城市

@end
