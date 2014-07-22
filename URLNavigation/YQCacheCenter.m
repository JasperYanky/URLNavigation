//
//  YQCacheCenter.m
//  URLNavigation
//
//  Created by Jasper on 14-7-22.
//  Copyright (c) 2014年 Jasper. All rights reserved.
//

#import "YQCacheCenter.h"

@implementation YQCacheCenter

+(YQCacheCenter *)shareCacheCenter{
    static YQCacheCenter *shareCacheCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareCacheCenter = [[YQCacheCenter alloc] init];
    });
    return shareCacheCenter;
}



- (id)init
{
    self = [super init];
    if (self) {
        _mainCache = [[NSCache alloc]init];
        _imageCache = [[NSCache alloc]init];
    }
    return self;
}


@end
