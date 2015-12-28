//
//  AppDelegate.m
//  微博MQ
//
//  Created by qingyun on 15/12/26.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "AppDelegate.h"
#import "Common.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //[self.window setBackgroundColor:[UIColor whiteColor]];
    
//    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    UIViewController *vc = [board instantiateViewControllerWithIdentifier:@"guide"];
    
    self.window.rootViewController = [self instantiateRootViewController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


-(instancetype)instantiateRootViewController
{
    //首先取出当前运行的版本号，然后取出之前保存的版本，判断如果版本号一样，说明这个版本之前已经运行过了，反正，当前运行的是一个全新的版本
    
    NSString *currentVersion = [[NSBundle mainBundle]objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    //取出本地的运行版本
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *save = [defaults objectForKey:kAppVersion];
    
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if ([currentVersion isEqualToString:save]) {
        //返回tabbarVC
        return [storyBoard  instantiateViewControllerWithIdentifier:@"main"];
    }else{
        //返回引导页
        return [storyBoard instantiateViewControllerWithIdentifier:@"guide"];
    }
    
}


-(void)guide
{
    //引导结束
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *vc = [board instantiateViewControllerWithIdentifier:@"main"];
    self.window.rootViewController = vc;
    
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)  kCFBundleVersionKey];
    
    //更新本地保存的版本
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:kAppVersion];
    
    //更新到物理文件中
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
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
