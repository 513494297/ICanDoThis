//
//  HttpUtil.h
//  ICanDoThis
//
//  Created by THF on 16/8/29.
//  Copyright © 2016年 thf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUtil : NSObject

+(void)postURL:(NSString *)url
    parameters:(NSDictionary *)parameters
       success:(void (^)(id data))apiSuccess
       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+(void)getURL:(NSString *)url
   parameters:(NSDictionary *)parameters
      success:(void (^)(id data))apiSuccess
      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
