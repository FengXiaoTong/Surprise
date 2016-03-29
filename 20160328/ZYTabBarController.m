//
//  ZYTabBarController.m
//  20160328
//
//  Created by runsheng on 16/3/28.
//  Copyright © 2016年 runsheng. All rights reserved.
//

#import "ZYTabBarController.h"
#import "UIImage+ZYOriginal.h"

@interface ZYTabBarController ()

@end

@implementation ZYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self  setUpChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//9.0之后，appearanceWhenContainedIn方法不再使用 ！新的appearance方法，修改所以外观属性，（基本方法不变）参数变为NSArray class.
+(void)initialize
{
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    NSMutableDictionary *atts = [NSMutableDictionary dictionary];
    atts[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:atts forState:UIControlStateSelected];
}

-(void)setUpChildViewControllers
{
    //1.创建首页
    UIViewController *First = [[UIViewController alloc]init];
    [self setOneViewController:First image:[UIImage imageNamed:@"" ] selectedImage:[UIImage imageWithOriginalName:@""] title:@"首页"];
    First.view.backgroundColor = [UIColor redColor];
    
    //2.创建简历
    UIViewController *message = [[UIViewController alloc]init];
     [self setOneViewController:message image:[UIImage imageNamed:@"" ] selectedImage:[UIImage imageWithOriginalName:@""] title:@"简历"];
      message.view.backgroundColor = [UIColor blueColor];
    
    //3.创建发现
    UIViewController *discover= [[UIViewController alloc]init];
    [self setOneViewController:discover image:[UIImage imageNamed:@"" ] selectedImage:[UIImage imageWithOriginalName:@""] title:@"发现"];
    discover.view.backgroundColor = [UIColor yellowColor];
    
    //4.创建我的
    UIViewController *Mine = [[UIViewController alloc]init];
    [self setOneViewController:Mine image:[UIImage imageNamed:@"" ] selectedImage:[UIImage imageWithOriginalName:@""] title:@"我的"];
    Mine.view.backgroundColor = [UIColor greenColor];
}


-(void)setOneViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    navc.tabBarItem.title = title;
    navc.tabBarItem.image = image;
    navc.tabBarItem.selectedImage = selectedImage;
//    vc.tabBarItem.badgeValue = @"15";  消息数提醒
    [self addChildViewController:navc];

}


@end
