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
    UIBezierPath * p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 400, 100, 100)];
    [[UIColor blueColor] setFill];
    [p fill];
    
    //方法二：使用Core Graphics实现绘制蓝色圆
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(100,400,100,100));
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
    
    
    
    CGPoint center = CGPointMake(100, 100);  //设置圆心位置
    CGFloat radius = 90;  //设置半径
    CGFloat startA = - M_PI_2;  //圆起点位置
    CGFloat endA = -M_PI_2 + M_PI * 2 * 0.6;  //圆终点位置
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    CGContextSetLineWidth(context, 10); //设置线条宽度
    [[UIColor blueColor] setStroke]; //设置描边颜色
    
    CGContextAddPath(context, path.CGPath); //把路径添加到上下文
    
    CGContextStrokePath(context);  //渲染
    
    
    
    
    
   
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
    
    
    
    
    
    [path moveToPoint:CGPointMake(20, 20)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - 40, 20)];
    [path addLineToPoint:CGPointMake(self.frame.size.width / 2, self.frame.size.height - 20)];
    
    // 最后的闭合线是可以通过调用closePath方法来自动生成的，也可以调用-addLineToPoint:方法来添加
    //  [path addLineToPoint:CGPointMake(20, 20)];
    
    [path closePath];
    
    // 设置线宽
    path.lineWidth = 1.5;
    
    // 设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
  //  [path fill];
    
    // 设置画笔颜色
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    
    // 根据我们设置的各个点连线
    [path stroke];
    
    
    
    
    
    
    UIBezierPath *paths = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.width - 40)];
    
    // 设置填充颜色
//    UIColor *fillColors = [UIColor greenColor];
//    [fillColors set];
//    [paths fill];
    
    // 设置画笔颜色
    UIColor *strokeColors = [UIColor blueColor];
    [strokeColors set];
    
    // 根据我们设置的各个点连线
    [paths stroke];
    
    
    
    
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
