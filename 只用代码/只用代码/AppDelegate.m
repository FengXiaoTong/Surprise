//
//  AppDelegate.m
//  只用代码
//
//  Created by qingyun on 16/1/18.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "AppDelegate.h"
#import "STabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


//知识点补充： UITabBarController控制器的View在一创建的时候就会加载View 走 view didload方法
//只有UIViewController控制器的View才使用懒加载方法！

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    //实例化window
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor greenColor];
    
    //创建STabBarController
    STabBarController *tabVC = [[STabBarController alloc]init];
    tabVC.view.backgroundColor = [UIColor blueColor];
    
    //设置tabVC作为试图的根试图控制器
    [self.window setRootViewController:tabVC];
   // NSLog(@"%@",application.keyWindow);此时是没有值的，是null
    
    //显示窗口 makeKeyAndVisible的底层实现：1.application.keyWindow = self.window   2.self.window.hidden = NO;
    [self.window makeKeyAndVisible];
   // NSLog(@"%@",application.keyWindow); 走过[self.window makeKeyAndVisible]之后才有值，所以说2是makeKeyAndVisible的底层实现
    
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
