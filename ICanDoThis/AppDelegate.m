//
//  AppDelegate.m
//  ICanDoThis
//
//  Created by THF on 16/8/16.
//  Copyright © 2016年 thf. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabViewController.h"
#import "AFNetworkReachabilityManager.h"
#import "LeftMenuController.h"
#import "YQSlideMenuController.h"
#import "PAirSandbox.h"
#import "Tools.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    MainTabViewController * m = [[MainTabViewController alloc]init];
    LeftMenuController  *leftMenuViewController = [[LeftMenuController alloc] init];
    YQSlideMenuController *sideMenuController = [[YQSlideMenuController alloc] initWithContentViewController:m
                                                                                      leftMenuViewController:leftMenuViewController];
    sideMenuController.scaleContent = NO;//是否缩放
    self.window.rootViewController = sideMenuController;
     self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self weatherNetWork];
    
#ifdef DEBUG
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[PAirSandbox sharedInstance] enableSwipe];
    });
#endif

    InstallUncaughtExceptionHandler();

    return YES;
}

- (void)weatherNetWork
{
    //设置网络监听
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                [Tools showMessage:@"未知网络"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                [Tools showMessage:@"网络连接已断开，请检查网络配置"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                break;
        }
    }];
    [mgr startMonitoring];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
