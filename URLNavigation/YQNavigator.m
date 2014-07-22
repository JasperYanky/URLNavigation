//
//  YQNavigator.m
//  URLNavigation
//
//  Created by Jasper on 14-7-21.
//  Copyright (c) 2014年 Jasper. All rights reserved.
//

#import "YQNavigator.h"

#import "NSString+YQ.h"
#import "YQDefine.h"
#import "ViewControllers.h"

@implementation YQNavigator
+ (void)showViewControllerToURL:(NSString*)aURL from:(YQBaseViewController *)aViewController
{
    
    
    NSLog(@"open url %@",aURL);
    
    if (aURL && 0 < [aURL length]) {
        NSDictionary *urlDict = [aURL paramsFromURL];
        if ([YQPROTOCOL isEqual:[urlDict objectForKey:PROTOCOL]]) {
            
            if ([AVC isEqual:[urlDict objectForKey:HOST]]) {
                AViewController *aVC = [[AViewController alloc]init];
                aVC.yqNavigationController = aViewController.yqNavigationController;
                [aViewController.yqNavigationController pushViewController:aVC animated:YES];
            }
            
            if ([BVC isEqual:[urlDict objectForKey:HOST]]) {
                NSNumber *messageID = [[urlDict objectForKey:PARAMS] objectForKey:@"messageID"];
                
                NSLog(@"sssss :: %@",messageID);
                BViewController *aVC = [[BViewController alloc]init];
                [aVC loadMessageID:messageID];
                aVC.yqNavigationController = aViewController.yqNavigationController;
                [aViewController.yqNavigationController pushViewController:aVC animated:YES];
            }
            
            if ([CVC isEqual:[urlDict objectForKey:HOST]]) {
                CViewController *aVC = [[CViewController alloc]init];
                aVC.yqNavigationController = aViewController.yqNavigationController;
                [aViewController.yqNavigationController pushViewController:aVC animated:YES];
            }
            
            if ([DVC isEqual:[urlDict objectForKey:HOST]]) {
                DViewController *aVC = [[DViewController alloc]init];
                aVC.yqNavigationController = aViewController.yqNavigationController;
                [aViewController.yqNavigationController pushViewController:aVC animated:YES];
            }
            
            if ([EVC isEqual:[urlDict objectForKey:HOST]]) {
                EViewController *aVC = [[EViewController alloc]init];
                aVC.yqNavigationController = aViewController.yqNavigationController;
                [aViewController.yqNavigationController pushViewController:aVC animated:YES];
            }
        }
    }
}


@end
