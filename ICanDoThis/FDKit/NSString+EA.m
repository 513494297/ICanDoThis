//
//  NSString+EA.m
//  AshineDoctor
//
//  Created by Lipeng on 15-7-30.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import "NSString+EA.h"
#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

@implementation NSString(EA)
- (CGSize)eaSizeWithFont:(UIFont *)font
{
    CGSize size = CGSizeZero;
    if ([self respondsToSelector:@selector(sizeWithFont:)]){
        size = [self sizeWithFont:font];
    }
    if ([self respondsToSelector:@selector(sizeWithAttributes:)]){
        size = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    }
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

- (CGSize)eaSizeWithFont:(UIFont *)font maxWidth:(CGFloat)width
{
    CGSize size = CGSizeZero;
    if ([self respondsToSelector:@selector(sizeWithFont:constrainedToSize:lineBreakMode:)]){
        size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width,100000.f) lineBreakMode:NSLineBreakByCharWrapping];
    } else {
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self];
        [text addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0,self.length)];
        return [text eaSizeWithMaxWidth:width];
    }
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)md5Lowcase
{
    return [[self md5] lowercaseString];
}

- (NSString *)URLEncodedString
{
    return [self URLEncodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}

- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding
{
    return (__bridge  NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[self mutableCopy], NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), encoding);
}

- (NSString *)URLDecodeString
{
    return (__bridge  NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(CFStringRef)self, CFSTR(""),kCFStringEncodingUTF8);
}

- (NSDate *)dateValue
{
    if (self.length < strlen("yyyy-MM-dd HH:mm:ss")) {
        return [NSDate date];
    }
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
    if (nil != [df dateFromString:self]) {
        return [df dateFromString:self];
    }
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [df dateFromString:self];
}

- (NSString *)agoString:(BOOL)hasTime
{
    return [self.dateValue agoString:hasTime];
}

- (NSString *)agoYYYYMMddString
{
    return [self.dateValue agoYYYYMMddString];
}

- (BOOL)isBlank
{
    return (0 == [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length);
}

- (BOOL)isValidMobileNumber
{
    //手机号以13，14，15，18开头，八个 \d 数字字符
    NSString *regex = @"^((13[0-9])|(14[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [test evaluateWithObject:self];
}

- (BOOL)isValidPhoneNumber
{
    NSString *regex = @"\\d{3}-\\d{8}|\\d{4}-\\d{7}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [test evaluateWithObject:self];
}
@end
