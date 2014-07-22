//
//  NSString+PX.m
//  Paixin
//
//  Created by Jasper on 14-3-4.
//  Copyright (c) 2014年 Jasper. All rights reserved.
//

#import "NSString+YQ.h"
#include <ctype.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (YQ)

- (NSDictionary *)paramsFromURL {
    NSString *protocolString = @"";
    NSString *tmpString = @"";
	NSString *hostString = @"";
    NSString *uriString = @"/";
    
    if (NSNotFound != [self rangeOfString:@"://"].location) {
        protocolString = [self substringToIndex:([self rangeOfString:@"://"].location)];
        tmpString = [self substringFromIndex:([self rangeOfString:@"://"].location + 3)];
    }
    
	if (NSNotFound != [tmpString rangeOfString:@"/"].location) {
		hostString = [tmpString substringToIndex:([tmpString rangeOfString:@"/"].location)];
        tmpString = [self substringFromIndex:([self rangeOfString:hostString].location + [self rangeOfString:hostString].length)];
	}
	else if (NSNotFound != [tmpString rangeOfString:@"?"].location) {
		hostString = [tmpString substringToIndex:([tmpString rangeOfString:@"?"].location)];
        if (0 < hostString.length) {
            tmpString = [self substringFromIndex:([self rangeOfString:hostString].location + [self rangeOfString:hostString].length)];
        }
	}
	else {
		hostString = tmpString;
        tmpString = nil;
	}
	
    if (tmpString) {
        if (NSNotFound != [tmpString rangeOfString:@"/"].location) {
            if (NSNotFound != [tmpString rangeOfString:@"?"].location) {
                uriString = [tmpString substringToIndex:[tmpString rangeOfString:@"?"].location];
            }
            else {
                uriString = tmpString;
            }
        }
    }
	NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
	if (NSNotFound != [self rangeOfString:@"?"].location) {
		NSString *paramString = [self substringFromIndex:([self rangeOfString:@"?"].location + 1)];
		NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
		NSScanner* scanner = [[NSScanner alloc] initWithString:paramString];
		while (![scanner isAtEnd]) {
			NSString* pairString = nil;
			[scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
			[scanner scanCharactersFromSet:delimiterSet intoString:NULL];
			NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
			if (kvPair.count == 2) {
				NSString* key = [[kvPair objectAtIndex:0] urldecode];
				NSString* value = [[kvPair objectAtIndex:1] urldecode];
				[pairs setObject:value forKey:key];
			}
		}
	}
	return [NSDictionary dictionaryWithObjectsAndKeys:
			pairs, PARAMS,
			protocolString, PROTOCOL,
			hostString, HOST,
			[uriString urldecode], PATH, nil];
}

- (NSString*)addUrlFromDictionary:(NSDictionary*)params {
    NSMutableString *_add = nil;
    if (NSNotFound != [self rangeOfString:@"?"].location) {
        _add = [NSMutableString stringWithString:@"&"];
    }else {
        _add = [NSMutableString stringWithString:@"?"];
    }
    for (NSString* key in [params allKeys]) {
        if ([params objectForKey:key] && 0 < [[params objectForKey:key] length]) {
            [_add appendFormat:@"%@=%@&",key,[[params objectForKey:key] urlencode]];
        }
    }
    
    return [NSString stringWithFormat:@"%@%@",self,[_add substringToIndex:[_add length] - 1]];
}

- (NSString *)urldecode {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlencode {
	NSString *encUrl = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	int len = [encUrl length];
	const char *c;
	c = [encUrl UTF8String];
	NSString *ret = @"";
	for(int i = 0; i < len; i++) {
		switch (*c) {
			case '/':
				ret = [ret stringByAppendingString:@"%2F"];
				break;
			case '\'':
				ret = [ret stringByAppendingString:@"%27"];
				break;
			case ';':
				ret = [ret stringByAppendingString:@"%3B"];
				break;
			case '?':
				ret = [ret stringByAppendingString:@"%3F"];
				break;
			case ':':
				ret = [ret stringByAppendingString:@"%3A"];
				break;
			case '@':
				ret = [ret stringByAppendingString:@"%40"];
				break;
			case '&':
				ret = [ret stringByAppendingString:@"%26"];
				break;
			case '=':
				ret = [ret stringByAppendingString:@"%3D"];
				break;
			case '+':
				ret = [ret stringByAppendingString:@"%2B"];
				break;
			case '$':
				ret = [ret stringByAppendingString:@"%24"];
				break;
			case ',':
				ret = [ret stringByAppendingString:@"%2C"];
				break;
			case '[':
				ret = [ret stringByAppendingString:@"%5B"];
				break;
			case ']':
				ret = [ret stringByAppendingString:@"%5D"];
				break;
			case '#':
				ret = [ret stringByAppendingString:@"%23"];
				break;
			case '!':
				ret = [ret stringByAppendingString:@"%21"];
				break;
			case '(':
				ret = [ret stringByAppendingString:@"%28"];
				break;
			case ')':
				ret = [ret stringByAppendingString:@"%29"];
				break;
			case '*':
				ret = [ret stringByAppendingString:@"%2A"];
				break;
			default:
				ret = [ret stringByAppendingFormat:@"%c", *c];
		}
		c++;
	}
    
	return ret;
}

- (NSString *)MD5 {
    if(self == nil || [self length] == 0)
        return nil;
    
	const char* str = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(str, strlen(str), result);
	
	NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
	for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
		[ret appendFormat:@"%02x",result[i]];
	}
	return ret;
}

- (NSString *)substringFromIndex:(NSUInteger )fromIndex toIndex:(NSUInteger)toIndex {
	return [NSString stringWithString:[[self substringFromIndex:fromIndex] substringToIndex:(toIndex - fromIndex)]];
}


- (int)indexOfRightWidth:(CGFloat)width string:(NSString *)str font:(UIFont *)font{
    int finalIndex = 0;
    //CGSize testStrSize = [str sizeWithFont:font];
    //by jasper
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize testStrSize = [str boundingRectWithSize:testStrSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    
    
    if (testStrSize.width <= width) {
        finalIndex = str.length-1;
        return finalIndex;
    }
    
    int len = str.length;
    for (int i = 1; i < len; i++) {
        NSString *subStr = [str substringToIndex:i];
        
        //modify by jasper
        //CGSize testSubstrSize = [subStr sizeWithFont:font];
    
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        CGSize testSubstrSize = [subStr boundingRectWithSize:testSubstrSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
        
        
        
        if (testSubstrSize.width <= width) {
            finalIndex = i-1;
        } else if (testSubstrSize.width > width) {
            break;
        }
    }
    
    return finalIndex;
}

// 将string分割为一个个字串，字母群为以一块，其他（汉字的单字为一块，符号为单字为一块，）
- (NSArray *)arrayOfDividedIntoPiece {
    int currentBlockFromIndex = 0;
    int currentBlockToIndex = 0;
    int currentIndex = 0;
    int countAlpha = 0;
    
    //    NSString *str = self;
    NSMutableArray *finalArray = [NSMutableArray array];
    
    int len = self.length;
    for (; currentIndex < len; currentIndex++) {
        int c = [self characterAtIndex:currentIndex];
        
        if (isalpha(c)) {
            if (countAlpha <= 0) {
                currentBlockToIndex = currentIndex;
                NSString *blockStr = [self substringWithRange:NSMakeRange(currentBlockFromIndex, currentBlockToIndex-currentBlockFromIndex)];
                if (blockStr && ![@"" isEqualToString:blockStr]) {
                    [finalArray addObject:blockStr];
                }
            }
            countAlpha++;
            if (countAlpha == 1) {
                currentBlockFromIndex = currentIndex;
            }
            currentBlockToIndex = currentIndex + 1;
        } else {
            if (countAlpha > 0) {
                currentBlockToIndex = currentIndex;
                
                NSString *blockStr = [self substringWithRange:NSMakeRange(currentBlockFromIndex, currentBlockToIndex-currentBlockFromIndex)];
                if (blockStr && ![@"" isEqualToString:blockStr]) {
                    [finalArray addObject:blockStr];
                }
                
                currentBlockFromIndex = currentIndex;
                currentBlockToIndex = currentIndex + 1;
            } else {
                currentBlockToIndex = currentIndex;
                
                NSString *blockStr = [self substringWithRange:NSMakeRange(currentBlockFromIndex, currentBlockToIndex-currentBlockFromIndex)];
                if (blockStr && ![@"" isEqualToString:blockStr]) {
                    [finalArray addObject:blockStr];
                }
                
                currentBlockFromIndex = currentIndex;
                currentBlockToIndex = currentIndex + 1;
            }
            
            countAlpha = 0;
        }
    }
    // 将最后的子串也添加到数组中
    NSString *blockStr = [self substringWithRange:NSMakeRange(currentBlockFromIndex, currentBlockToIndex-currentBlockFromIndex)];
    if (blockStr && ![@"" isEqualToString:blockStr]) {
        [finalArray addObject:blockStr];
    }
    
    return finalArray;
}
// 截长子串（子串大于width宽度）为小子串
- (NSArray *)arrayOfWidthFilted:(CGFloat)width font:(UIFont *)font fromArray:(NSArray *)array {
    NSMutableArray *finalArray = [NSMutableArray array];
    for (NSString *string in array) {
        if ([@"" isEqualToString:string]) {
            break;
        }
        
        NSString *str = string;
        while (true) {
            int rightIndex = [self indexOfRightWidth:width string:str font:font] + 1;
            [finalArray addObject:[str substringToIndex:rightIndex]];
            str = [str substringFromIndex:rightIndex];
            
            if (str && ![@"" isEqualToString:str]) {
               // CGSize testStrSize = [str sizeWithFont:font];
                //by jasper
                
                NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
                CGSize testStrSize = [str boundingRectWithSize:testStrSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
                
                
                
                if (testStrSize.width <= width) {
                    [finalArray addObject:str];
                    break;
                }
            } else break;
        }
        
    }
    return finalArray;
}

@end

