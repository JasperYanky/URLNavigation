//
//  Sample.m
//  URLNavigation
//
//  Created by Jasper on 14-7-22.
//  Copyright (c) 2014年 Jasper. All rights reserved.
//

#import "Sample.h"
#import "YQDBCenter.h"
#import "YQCacheCenter.h"

@interface Sample()
//从数据库查询的对象中解析出一个sample对象
+ (Sample *)objectFromDBResultSet:(FMResultSet*)res;
@end


@implementation Sample
@synthesize messageID = _messageID;
@synthesize messageContent = _messageContent;

//同步存储
- (void)syncSave
{
    //存缓存
    [[YQCacheCenter shareCacheCenter].mainCache setObject:self forKey:self.messageID];
    
    //存数据库
    FMDatabase *db = [YQDBCenter syncDB];
    [Sample saveSample:self forDB:db];
}

//异步存储
- (void)asyncSave
{
    //存缓存
    [[YQCacheCenter shareCacheCenter].mainCache setObject:self forKey:self.messageID];
    //存数据库
    [[YQDBCenter dbQueue]inDatabase:^(FMDatabase *db){
         [Sample saveSample:self forDB:db];
    }];
}

//同步获取
+ (Sample *)syncFetchBy:(NSNumber *)messageID
{
    //先从缓存查找
    Sample *sample = nil;
    sample = [[YQCacheCenter shareCacheCenter].mainCache objectForKey:messageID];
    if (!sample) {
        //后从数据库查找
        FMDatabase *db = [YQDBCenter syncDB];
        sample = [Sample objectFromDB:db byMessageID:messageID];
    }
    return sample;
}

//异步获取
+ (void)asyncFetchBy:(NSNumber *)messageID doneBlock:(void (^)(Sample *))doneBlock
{
    Sample *sample = nil;
    sample = [[YQCacheCenter shareCacheCenter].mainCache objectForKey:messageID];
    //先从缓存查找
    if (sample) {
        doneBlock(sample);
    }else{
        //后从数据库查找
        [[YQDBCenter dbQueue]inDatabase:^(FMDatabase *db){
            doneBlock([Sample objectFromDB:db byMessageID:messageID]);
        }];
    }
}
#pragma mark - db base operation

+ (NSString *)creatSampleStructureforDB
{
    NSString *sql = @"CREATE  TABLE  IF NOT EXISTS 'message'('messageID' INTEGER PRIMARY KEY  NOT NULL  UNIQUE,'messageContent' TEXT)";
    return sql;
}


+ (void)saveSample:(Sample *)sample forDB:(FMDatabase *)db
{
    [db open];
    NSString *insertStr = @"REPLACE INTO 'message'(messageID,messageContent) VALUES (?,?)";
    [db executeUpdate:insertStr,sample.messageID,sample.messageContent];
    [db close];
}


+ (Sample *)objectFromDB:(FMDatabase *)db byMessageID:(NSNumber *)messageID
{
    [db open];
    Sample *sample = nil;
    NSString *isExistSql = [[NSString alloc]initWithFormat:@"select * from message where messageID = '%@'",messageID];
    FMResultSet *rs =[db executeQuery:isExistSql,nil];
    while ([rs next]) {
        sample = [Sample objectFromDBResultSet:rs];
    }
    [rs close];
    [db close];
    return sample;
}

+ (Sample *)objectFromDBResultSet:(FMResultSet*)res
{
    Sample *sample = [[Sample alloc]init];
    sample.messageID      = [res objectForColumnName:@"messageID"];
    sample.messageContent = [res objectForColumnName:@"messageContent"];
    return sample;
}


@end
