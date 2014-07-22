//
//  YQCacheCenter.h
//  URLNavigation
//
//  Created by Jasper on 14-7-22.
//  Copyright (c) 2014年 Jasper. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YQCacheCenter : NSObject
@property (nonatomic,strong) NSCache *mainCache;
@property (nonatomic,strong) NSCache *imageCache;

+ (YQCacheCenter *)shareCacheCenter;
//这个缓存是最简单的缓存，如果要更高级的，可以考虑归档等功能制作缓存
@end
