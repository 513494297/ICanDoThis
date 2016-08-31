//
//  MainTabViewController.m
//  ICanDoThis
//
//  Created by THF on 16/8/16.
//  Copyright © 2016年 thf. All rights reserved.
//

#import "MainTabViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"

@interface MainTabViewController ()<UITabBarControllerDelegate>{
    BOOL didLoad;
}

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self addViewControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)loadView
{
    [super loadView];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if ([self.tabBar respondsToSelector:@selector(setTranslucent:)]){
        self.tabBar.translucent  = NO;
    }
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:hf_color(91, 95, 116, 1)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:hf_color(1, 155, 232, 1)} forState:UIControlStateSelected];
}

- (void)addViewControllers
{
    NSArray *aa = @[@[OneViewController.class,    @"主页", @"tab_message", @"tab_message_s"],
                    @[TwoViewController.class,    @"一页", @"tab_flowup", @"tab_flowup_s"],
                    @[ThreeViewController.class,  @"二页", @"tab_medical", @"tab_medical_s"],
                    @[FourViewController.class,   @"设置", @"tab_me", @"tab_me_s"],
                    ];
    NSArray * va = [NSArray array];
    for (NSArray * a  in aa){
        va = [va arrayByAddingObject:[self viewControllerWithArray:a]];
    }
    self.viewControllers = va;
}

#pragma mark -
#pragma mark 加载四个控制器
#pragma mark -
#pragma mark 加载四个控制器
- (UINavigationController *)viewControllerWithArray:(NSArray *)array
{
    UIViewController * v = [[array[0] alloc]init];
    UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:v];
    v.title             = array[1];
    v.tabBarItem.title  = array[1];
    if (!VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
        v.tabBarItem.image =[UIImage imageNamed:array[2]];
        v.tabBarItem.selectedImage = [UIImage imageNamed:array[3]];
    } else {
        v.tabBarItem.image = [[UIImage imageNamed:array[2]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        v.tabBarItem.selectedImage = [[UIImage imageNamed:array[3]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return vc;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UINavigationController *)yq_navigationController {
    return self.selectedViewController;
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
