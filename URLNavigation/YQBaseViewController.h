//
//  YQBaseViewController.h
//  URLNavigation
//
//  Created by Jasper on 14-7-21.
//  Copyright (c) 2014年 Jasper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQNavigationViewController.h"
#import "YQDefine.h"
#import "NSString+YQ.h"
#import "YQNavigator.h"

@interface YQBaseViewController : UIViewController
@property (nonatomic, strong) YQNavigationViewController *yqNavigationController;


- (void)back;
@end
