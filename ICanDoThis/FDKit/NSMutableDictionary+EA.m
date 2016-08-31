//
//  NSMutableDictionary+EA.m
//  AshineDoctor
//
//  Created by Lipeng on 15-8-14.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import "NSMutableDictionary+EA.h"
#import <objc/runtime.h>

extern id eaDictionaryGetter(id self, SEL _cmd);

void eaDictionarySetter(id self, SEL _cmd, id object)
{
    NSMutableDictionary *dic = (NSMutableDictionary*)self;
    NSString *key = NSStringFromSelector(_cmd);
    key = [key substringWithRange:NSMakeRange(3, key.length-4)];
    dic[key] = object;
}

@implementation NSMutableDictionary(EA)
- (void)setEaValue:(NSString *)value forKey:(NSString *)key
{
    if (value.length > 0) {
        self[key] = value;
    }
}

+ (BOOL)resolveInstanceMethod:(SEL)method
{
    NSString *name = NSStringFromSelector(method);
    if ([name hasPrefix:@"get"]){
        class_addMethod(self, method, (IMP)eaDictionaryGetter, "@@:");
        return YES;
    } else if ([name hasPrefix:@"set"]){
        class_addMethod(self, method, (IMP)eaDictionarySetter, "v@:@");
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
