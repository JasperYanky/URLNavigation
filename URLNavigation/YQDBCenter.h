//
//  YQDBCenter.h
//  URLNavigation
//
//  Created by Jasper on 14-7-22.
//  Copyright (c) 2014年 Jasper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface YQDBCenter : NSObject
@property (nonatomic,strong) FMDatabaseQueue *dbQueue;
+ (YQDBCenter *)shareDatabase;

//获取一个异步的数据库队列
+ (FMDatabaseQueue *)dbQueue;

//获取一个同步的数据库
+ (FMDatabase *)syncDB;

@end
