//
//  OneViewController.h
//  ICanDoThis
//
//  Created by THF on 16/8/16.
//  Copyright © 2016年 thf. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock)(id data, BOOL result);//定义一个myBlock类型，方便调用
@interface OneViewController : UIViewController

- (void)senMessageWith:(myBlock)block;

@end
