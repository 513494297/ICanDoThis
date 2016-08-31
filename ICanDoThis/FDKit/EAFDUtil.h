//
//  EAFDUtil.h
//  AshineDoctor
//
//  Created by Lipeng on 15-8-3.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EAFDUtil : NSObject
+ (NSMutableAttributedString *)attributedString:(NSArray *)strings :(NSArray *)colors :(NSArray *)fonts;
+ (UIView *)callPhone:(NSString *)phone;
@end
