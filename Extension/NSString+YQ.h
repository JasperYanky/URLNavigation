//
//  NSString+PX.h
//  Paixin
//
//  Created by Jasper on 14-3-4.
//  Copyright (c) 2014年 Jasper. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 解析 协议的 Category 
 该类是Three20架构的一部分，用于解析URLManger 中具体协议命令
 */

/**
 *  @param NSString *URL 需要解析的URL，格式如：http://host.name/testpage/?keyA=valueA&amp;keyB=valueB
 *  @return NSDictionary *params 从URL中解析出的参数表
 *    PROTOCOL 如 http
 *    HOST     如 host.name
 *    PARAMS   如 {keyA:valueA, keyB:valueB}
 *    URI      如 /testpage
 */

#define PROTOCOL	@"PROTOCOL"   //协议类型
#define HOST		@"HOST"       //地址
#define PARAMS		@"PARAMS"     //参数
#define PATH		@"PATH"       //路径


@interface NSString (YQ)


- (NSDictionary *)paramsFromURL;
- (NSString *)addUrlFromDictionary:(NSDictionary*)params;
- (NSString *)urlencode;
- (NSString *)urldecode;
- (NSString *)MD5;

- (NSString *)substringFromIndex:(NSUInteger )fromIndex toIndex:(NSUInteger)toIndex;




@end
