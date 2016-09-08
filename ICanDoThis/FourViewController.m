//
//  FourViewController.m
//  ICanDoThis
//
//  Created by THF on 16/8/16.
//  Copyright © 2016年 thf. All rights reserved.
//

#import "FourViewController.h"
#import "ThreeViw.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.view = [[ThreeViw alloc]initWithFrame:self.view.frame];
}


- (FourViewController *(^)(NSString *))people
{
    return ^(NSString *name){
        return self;
    };
}


- (FourViewController *(^)())byBus
{
    return ^{
        NSLog(@"坐公交去");
        return self;
    };
}

- (FourViewController *(^)(NSString *))buyVegetables
{
    return ^(NSString *buyVege){
        NSLog(@"买:%@",buyVege);
        return self;
    };
}


- (void)test
{
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"之前 - %@", [NSThread currentThread]);
    
    dispatch_async(queue, ^{
        NSLog(@"sync之前 - %@", [NSThread currentThread]);
        dispatch_sync(queue, ^{
            NSLog(@"sync - %@", [NSThread currentThread]);
        });
        NSLog(@"sync之前 - %@", [NSThread currentThread]);
    });
    
    NSLog(@"之后 - %@", [NSThread currentThread]);
    
    
    
    
    
    
    //    @weakify(self);
    //    [self senMessageWith:^(id data, BOOL result) {
    //        @strongify(self);
    //        if(!self)
    //            return ;
    //    }];

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
