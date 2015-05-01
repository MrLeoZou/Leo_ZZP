//
//  DPAPI.h
//  apidemo
//
//  Created by ZhouHui on 13-1-28.
//  Copyright (c) 2013年 Dianping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPRequest.h"
#import "Singleton.h"
#define kDPAppKey             @"082884512"
#define kDPAppSecret          @"adec8137ff144f9fb0e084989eb0386c"

#ifndef kDPAppKey
#error
#endif

#ifndef kDPAppSecret
#error
#endif

@interface DPAPI : NSObject
single_interface(DPAPI)
- (DPRequest*)requestWithURL:(NSString *)url
					  params:(NSDictionary *)params
					delegate:(id<DPRequestDelegate>)delegate;

- (DPRequest *)requestWithURL:(NSString *)url
				 paramsString:(NSString *)paramsString
					 delegate:(id<DPRequestDelegate>)delegate;

@end