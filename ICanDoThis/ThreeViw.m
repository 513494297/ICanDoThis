//
//  ThreeViw.m
//  ICanDoThis
//
//  Created by THF on 16/9/6.
//  Copyright © 2016年 thf. All rights reserved.
//

#import "ThreeViw.h"

@implementation ThreeViw

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //绘制圆形  方法一：用UIKit在Cocoa为我们提供的当前上下文中完成绘图任务
//    UIBezierPath * p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)];
//    [[UIColor blueColor] setFill];
//    [p fill];
    
    //方法二：使用Core Graphics实现绘制蓝色圆
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(context, CGRectMake(100,400,100,100));
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextFillPath(context);
    
   
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 1.0);
    //设置颜色
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    //开始一个起始路径
    CGContextBeginPath(context);
    //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
    CGContextMoveToPoint(context, 100, 250);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, 300, 200);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, 0, 150);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, 50, 180);
    //连接上面定义的坐标点
    CGContextStrokePath(context);
    
    
}

//方法三
//- (void)drawLayer:(CALayer*)lay inContext:(CGContextRef)con {
//    
//    CGContextAddEllipseInRect(con, CGRectMake(200,100,100,100));
//    
//    CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
//    
//    CGContextFillPath(con);
//    
//}


@end
