//
//  EAFDUtil.m
//  AshineDoctor
//
//  Created by Lipeng on 15-8-3.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import "EAFDUtil.h"

@implementation EAFDUtil
+ (NSMutableAttributedString *)attributedString:(NSArray *)strings :(NSArray *)colors :(NSArray *)fonts
{
    NSAssert(strings.count == colors.count && strings.count == fonts.count, @"attributedStringWithStrings");
    NSString *text = [NSString string];
    for (NSString *s in strings) {
        text = [text stringByAppendingString:s];
    }
    NSMutableAttributedString *atext = [[NSMutableAttributedString alloc] initWithString:text];
    CGFloat x = 0;
    for (int i = 0; i < strings.count; i++) {
        NSString *s = strings[i];
        [atext addAttributes:@{NSForegroundColorAttributeName:colors[i], NSFontAttributeName:fonts[i]} range:NSMakeRange(x, s.length)];
        x += s.length;
    }
//    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
//    paragraph.alignment = NSTextAlignmentJustified;//设置对齐方式
//    paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
//    [atext addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, atext.length)];
    return atext;
}

+ (UIView *)callPhone:(NSString *)phone
{
    NSString *telUrl = [NSString stringWithFormat:@"tel://%@", phone];
    NSURL *telURL =[NSURL URLWithString:telUrl];
    if ([[UIApplication sharedApplication] canOpenURL:telURL]) {
        UIWebView *callWebview = [[UIWebView alloc] init];
        NSString *telUrl = [NSString stringWithFormat:@"tel://%@", phone];
        NSURL *telURL =[NSURL URLWithString:telUrl];// 貌似tel:// 或者 tel: 都行
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        return callWebview;
    } else if (![[UIApplication sharedApplication] canOpenURL:telURL]){
        //        提示该设备不支持拨打电话的功能
        UIAlertView *alert = [[UIAlertView alloc ] initWithTitle:nil message:@"您的设备不支持电话功能!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    return nil;
}
@end
