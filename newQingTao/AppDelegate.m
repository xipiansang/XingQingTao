//
//  AppDelegate.m
//  XingQingTao
//
//  Created by 刘中天 on 16/12/3.
//  Copyright © 2016年 西片桑. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ClassifyViewController.h"
#import "CartViewController.h"
#import "MyViewController.h"
#import "XPTabBarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //获取当前window
    self.window =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    NSArray *array=@[@"diamond1",@"Clip1",@"Cart1",@"people1"];
    NSArray *array1=@[@"diamond2",@"Clip2",@"Cart2",@"people2"];
    //创建一个tabBarController 将四个界面添加到tabBarController中
    XPTabBarViewController *tabB=[[XPTabBarViewController alloc]initWithArray:array :array1];
    HomeViewController *vc1=[[HomeViewController alloc] init];
    QTNavigationController *nav1=[[QTNavigationController alloc] initWithRootViewController:vc1];
    ClassifyViewController *vc2=[[ClassifyViewController alloc]init];
    QTNavigationController *nav2=[[QTNavigationController alloc] initWithRootViewController:vc2];
    CartViewController *vc3=[[CartViewController alloc]init];
    QTNavigationController *nav3=[[QTNavigationController alloc] initWithRootViewController:vc3];
    MyViewController *vc4=[[MyViewController alloc]init];
    QTNavigationController *nav4=[[QTNavigationController alloc] initWithRootViewController:vc4];
    
    //添加
    tabB.viewControllers=@[nav1,nav2,nav3,nav4];
    
    //把tab当做根视图并展示
    self.window.rootViewController=tabB;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
