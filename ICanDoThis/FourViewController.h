//
//  FourViewController.h
//  ICanDoThis
//
//  Created by THF on 16/8/16.
//  Copyright © 2016年 thf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myBlock)(id data, BOOL result);//定义一个myBlock类型，方便调用

@interface FourViewController : UIViewController

- (void)senMessageWith:(myBlock)block;


//利用block链式编程
//people方法返回block，block又返回FourViewController
- (FourViewController *(^)(NSString * name))people;
- (FourViewController *(^)())byBus;// 做公交
- (FourViewController *(^)(NSString *VegName))buyVegetables;

//这样调用 ：   self.people(@"我").byBus().buyVegetables(@"西红柿");
//因为people返回了self,而后面的.byBus 相当于 self.byBus

@end
