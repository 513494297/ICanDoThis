//
//  HttpUtil.m
//  ICanDoThis
//
//  Created by THF on 16/8/29.
//  Copyright © 2016年 thf. All rights reserved.
//

#import "HttpUtil.h"
#import "AFHTTPSessionManager.h"
#import "Tools.h"


@implementation HttpUtil

+(void)postURL:(NSString *)url
    parameters:(NSDictionary *)parameters
       success:(void (^)(id data))apiSuccess
       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSLog(@"postToUrl:%@ \nparameters:%@",url,parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json",@"text/plain" ,@"text/json",@"text/html", nil];
   [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
       
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       if (apiSuccess) {
           apiSuccess(responseObject);
       }
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       if (failure) {
           failure(task,error);
           NSLog(@"%@",[error localizedDescription]);
       }
   }];
}

+(void)getURL:(NSString *)url
   parameters:(NSDictionary *)parameters
      success:(void (^)(id data))apiSuccess
      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSLog(@"postToUrl:%@ \nparameters:%@",url,parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json",@"text/html", nil];
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Result:%@ ",responseObject);
        
        if (apiSuccess) {
            apiSuccess(responseObject);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(task,error);
        }

        
    }];
    
}

//上传照片
+(void)UpLoadPicWith:(NSString *)url
          parameters:(NSDictionary *)parameters
          imageArray:(NSMutableArray *)images
             success:(void (^)(id data))apiSuccess
             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json",@"text/html", nil];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        int i = 0;
        //根据当前系统时间生成图片名称
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateString = [formatter stringFromDate:date];
        
        for (__strong UIImage *image in images) {
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateString,i];
            image = [Tools imageWithImageSimple:image scaledToSize:CGSizeMake(100, 150)];
            NSData *imageData;
            imageData = UIImageJPEGRepresentation(image, 0.1);
            
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"pic%d",i] fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            i ++;
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Result:%@ ",responseObject);
        
        if (apiSuccess) {
            apiSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(task,error);
        }
    }];
}


@end
