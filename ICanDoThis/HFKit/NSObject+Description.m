//
//  NSObject+Description.m
//  ICanDoThis
//
//  Created by THF on 16/8/22.
//  Copyright © 2016年 thf. All rights reserved.
//

#import "NSObject+Description.h"

static char kSomeKey;

@implementation NSObject (Description)

//+ (void)load
//{
//    Method  a = class_getInstanceMethod(self, @selector(description));
//    Method  b = class_getInstanceMethod(self, @selector(descriptionDetail));
//    method_exchangeImplementations(a, b);
//}


- (NSString *)descriptionDetail{
    //当然，如果你有兴趣知道出类名字和对象的内存地址，也可以像下面这样调用super的description方法
   NSString * desc = [self descriptionDetail];//交换方法后，调用自己就是调用description
  //  NSString * desc = @"\n";
    
    unsigned int outCount;
    //获取obj的属性数目
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //获取property的C字符串
        const char * propName = property_getName(property);
        if (propName) {
            //获取NSString类型的property名字
            NSString    * prop = [NSString stringWithCString:propName encoding:[NSString defaultCStringEncoding]];
            //获取property对应的值
            id obj = [self valueForKey:prop];
            //将属性名和属性值拼接起来
            desc = [desc stringByAppendingFormat:@"\n%@ : %@;\n",prop,obj];
        }
    }
    
    free(properties);
    return desc;
}

@end
