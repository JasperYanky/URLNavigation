//
//  YQDBCenter.m
//  URLNavigation
//
//  Created by Jasper on 14-7-22.
//  Copyright (c) 2014年 Jasper. All rights reserved.
//

#import "YQDBCenter.h"
#import "Sample.h"

#define kDBName  @"yq.sqlite3"

@implementation YQDBCenter

+(YQDBCenter *)shareDatabase{
    static YQDBCenter *shareDatabase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareDatabase = [[YQDBCenter alloc] init];
    });
    return shareDatabase;
}

+(FMDatabaseQueue *)dbQueue
{
    return  [YQDBCenter shareDatabase].dbQueue;
}

+(FMDatabase *)syncDB
{
    return [[FMDatabase alloc]initWithPath:[YQDBCenter databasePath]];
}


#pragma mark - 

- (id)init
{
    self = [super init];
    if (self) {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:[YQDBCenter databasePath]];
        [YQDBCenter creatDatabase];
    }
    return self;
}

#pragma mark - database base operation
+ (NSString *)databasePath
{
    NSString *applicationSupportPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/DB"];
    if (![[NSFileManager defaultManager]fileExistsAtPath:applicationSupportPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:applicationSupportPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
	return  [applicationSupportPath stringByAppendingString:[NSString stringWithFormat:@"/%@",kDBName]];
}

+ (void)creatDatabase
{
    //创建好友数据库 以及 信息数据库
    FMDatabase *db = [YQDBCenter syncDB];
    [db open];
    BOOL isWork = [db executeUpdate:[Sample creatSampleStructureforDB]];
    
    if (isWork) {
        NSLog(@"creatDatabase success ~");
    }else{
        NSLog(@"creatDatabase fail ~");
    }
    
    [db close];
}





@end
