//
//  TGDockController.h
//  东莞团购平台
//
//  Created by mac on 14-11-3.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGDock.h"

@interface TGDockController : UIViewController
{

    TGDock *_dock;
}

@property (nonatomic, readonly) UIViewController *selectedController;

@end
