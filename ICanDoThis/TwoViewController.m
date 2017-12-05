//
//  TwoViewController.m
//  ICanDoThis
//
//  Created by THF on 16/8/16.
//  Copyright © 2016年 thf. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@property(nonatomic,copy)NSArray * array1;
@property(nonatomic,strong)NSArray * array2;
@property(nonatomic,strong)NSArray * array3;
@property(nonatomic,strong)NSArray * array4;

@property (nonatomic, copy) NSMutableArray *scopyMutableArr;


@property(nonatomic,strong)UIAttachmentBehavior * attach;

@property (nonatomic, strong) NSString *strongString;
@property (nonatomic, copy) NSString *copyedString;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;//在导航栏透明的情况下，默认零点是从（0,0）开始，但是有导航栏，所以我们想要的零点应该是64开始的，所以加上这句话，在xib上就不用在上面留白了，直接从0开始布局，显示的就是navigation下方
    
    UIView *view1 = [[UIButton alloc]init];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.centerX.equalTo(self.view);
        make.top.width.offset(90);
    }];
    
    UIView *view2 = [[UILabel alloc]init];
    view2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.equalTo(view1);
        make.top.equalTo(view1.mas_bottom).with.offset(20);
    }];
    
    
    self.attach = [[UIAttachmentBehavior alloc] initWithItem:view1 attachedToItem:view2];
    self.attach.length = 100;// 距离
    self.attach.damping = 0.3;// 阻尼系数（阻碍变化）
    self.attach.frequency = 0.5;// 振动频率，（变化速度）
    
    //self.attach.anchorPoint = CGPointMake(100, 100);
    
   // [self.animator addBehavior:self.attach];
    
    
    NSMutableArray * mArray = [NSMutableArray array];
    [mArray addObject:@"k"];
    self.array1 = mArray;//array1 = k
    self.array2 = mArray;//array2 = k,b
    self.array3 = [mArray copy];//array3 = k
    self.array4 = [mArray mutableCopy];//array4 = k
    [mArray addObject:@"b"];
       NSLog(@"array1 = %@,array2 = %@, array3 = %@, array4 = %@",self.array1,self.array2,self.array3, self.array4);
    
    
    int a = 1;
    int * p = &a;
    
    
    NSMutableString *string = [NSMutableString stringWithFormat:@"abc"];
    self.strongString = string;
    self.copyedString = string;
    NSLog(@"origin string: %@ %p, %p",string, string, &string);
    NSLog(@"strong string:%@ %p, %p", _strongString, _strongString, &_strongString);
    NSLog(@"copy string:  %@ %p, %p", _copyedString, _copyedString, &_copyedString);
    
    
   [string appendString:@"修改"];
    
    NSLog(@"origin string: %@ %p, %p",string, string, &string);
    NSLog(@"strong string:%@ %p, %p", _strongString, _strongString, &_strongString);
    NSLog(@"copy string:  %@ %p, %p", _copyedString, _copyedString, &_copyedString);
    
    //可以发现，此时copy属性字符串已不再指向string字符串对象，而是深拷贝了string字符串，并让_copyedString对象指向这个字符串。
    //此时，我们如果去修改string字符串的话，可以看到：因为_strongString与string是指向同一对象，所以_strongString的值也会跟随着改变(需要注意的是，此时_strongString的类型实际上是NSMutableString，而不是NSString)；而_copyedString是指向另一个对象的，所以并不会改变。
  
    id ss = @[@"ca"];
    NSMutableArray *arrM = [NSMutableArray arrayWithObjects:@"123",@"456", nil];
    self.scopyMutableArr = ss;
    // 下面代码崩溃
    //[self.scopyMutableArr addObject:@"789"];
    //因为self.arr为copy修饰，那么self.arr = arrM就相当于_arr = [arrM copy],[arrM copy];返回的是不可变类型，即NSArray，向一个NSArray对象发送addObject消息当然方法找不到崩溃。
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
