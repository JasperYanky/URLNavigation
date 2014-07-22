//
//  YQNavigator.h
//  URLNavigation
//
//  Created by Jasper on 14-7-21.
//  Copyright (c) 2014年 Jasper. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YQNavigationViewController;
@class YQBaseViewController;

//主要的解析器
@interface YQNavigator : NSObject
+ (void)showViewControllerToURL:(NSString*)aURL
                           from:(YQBaseViewController*)aViewController;

@end
