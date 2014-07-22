//
//  Sample.h
//  URLNavigation
//
//  Created by Jasper on 14-7-22.
//  Copyright (c) 2014年 Jasper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sample : NSObject
@property (nonatomic,strong) NSNumber *messageID;
@property (nonatomic,strong) NSString *messageContent;

//同步存储
- (void)syncSave;

//异步存储
- (void)asyncSave;

//同步获取
+ (Sample *)syncFetchBy:(NSNumber *)messageID;

//异步获取
+ (void)asyncFetchBy:(NSNumber *)messageID doneBlock:(void (^)(Sample *))doneBlock;

//创建数据的sql语句
+ (NSString *)creatSampleStructureforDB;

@end
