//
//  AHI.m
//  AshineDoctor
//
//  Created by Lipeng on 15-6-9.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import "NSDictionary+EA.h"
#import <objc/runtime.h>

id eaDictionaryGetter(id self, SEL _cmd)
{
    NSDictionary *dic = (NSDictionary*)self;
    NSString *key = NSStringFromSelector(_cmd);
    key = [key substringFromIndex:3];
    id ret = [dic objectForKey:key];
    
    if ([ret isKindOfClass:NSNumber.class]) {
        NSAssert(NO, @"get %@", key);
    }
    
    return ((nil == ret) || ([NSNull null] == ret))? @"" : ret;
}


@implementation NSDictionary(EA)
+ (BOOL)resolveInstanceMethod:(SEL)method
{
    NSString *name = NSStringFromSelector(method);
    if ([name hasPrefix:@"get"]){
        class_addMethod(self, method, (IMP)eaDictionaryGetter, "@@:");
        return YES;
    }
    return [super resolveInstanceMethod:method];
}

- (NSString *)jsonText
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end
