//
//  NSString+EA.h
//  AshineDoctor
//
//  Created by Lipeng on 15-7-30.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(EA)
- (CGSize)eaSizeWithFont:(UIFont *)font;
- (CGSize)eaSizeWithFont:(UIFont *)font maxWidth:(CGFloat)width;
- (NSString *)md5;
- (NSString *)md5Lowcase;
- (NSString *)URLEncodedString;
- (NSString *)URLDecodeString;
- (NSDate *)dateValue;
- (NSString *)agoString:(BOOL)hasTime;
- (NSString *)agoYYYYMMddString;
- (BOOL)isValidMobileNumber;
- (BOOL)isValidPhoneNumber;
- (BOOL)isBlank;
@end
