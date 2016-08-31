//
//  OneViewController.m
//  ICanDoThis
//
//  Created by THF on 16/8/16.
//  Copyright © 2016年 thf. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@property (nonatomic,strong)NSArray * array;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"1",@"3"];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(100, 100, 100, 100);
    
    btn.backgroundColor = [UIColor blackColor];
    
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:btn];
  
}

- (void)btnclick
{
    
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
