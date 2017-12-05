//
//  CameraManager.h
//  aaaaa
//
//  Created by huafangT on 17/7/25.
//  Copyright © 2017年 huafangT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^pickImgBlock)(UIImage *);

@interface CameraManager : NSObject

+ (CameraManager *)shareInstance;

@property(nonatomic, copy)pickImgBlock imgBlock;

- (void)picSourceTypeCamera;

@end
