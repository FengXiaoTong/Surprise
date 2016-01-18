//
//  AppDelegate.m
//  只用代码
//
//  Created by qingyun on 16/1/18.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //实例化window
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor greenColor];
    
    //创建UITabBarController作为试图的根试图控制器
    UITabBarController *tabVC = [[UITabBarController alloc]init];
    tabVC.view.backgroundColor = [UIColor blueColor];
    [self.window setRootViewController:tabVC];
    
    //管理添加tabVC的子视图
    //1.home 首页
    UIViewController *home = [[UIViewController alloc]init];
    home.view.backgroundColor = [UIColor redColor];
    [tabVC addChildViewController:home];
    
    //2.message 信息
    UIViewController *message = [[UIViewController alloc]init];
    message.view.backgroundColor = [UIColor yellowColor];
    [tabVC addChildViewController:message];
    
    //3.discover 发现
    UIViewController *discover = [[UIViewController alloc]init];
    discover.view.backgroundColor = [UIColor grayColor];
    [tabVC addChildViewController:discover];
    
    //4.profile 我
    UIViewController *profile = [[UIViewController alloc]init];
    profile.view.backgroundColor = [UIColor purpleColor];
    [tabVC addChildViewController:profile];
    
    
    
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
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
