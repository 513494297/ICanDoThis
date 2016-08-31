//
//  NSMutableAttributedString+EA.m
//  AshineDoctor
//
//  Created by Lipeng on 15-8-3.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import "NSMutableAttributedString+EA.h"

@implementation NSMutableAttributedString(EA)
//设置行间距
- (void)setLineSpacing:(CGFloat)height
{
    NSMutableParagraphStyle * ps = [[NSMutableParagraphStyle alloc] init];
    ps.lineSpacing = height;
    [self addAttribute:NSParagraphStyleAttributeName value:ps range:NSMakeRange(0, self.length)];
}

//设置对其方式
- (void)setAlignment:(NSTextAlignment)alignment
{
    NSMutableParagraphStyle * ps = [[NSMutableParagraphStyle alloc] init];
    ps.alignment = alignment;
    [self addAttribute:NSParagraphStyleAttributeName value:ps range:NSMakeRange(0, self.length)];
}
@end
