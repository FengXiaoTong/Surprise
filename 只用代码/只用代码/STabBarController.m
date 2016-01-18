//
//  STabBarController.m
//  只用代码
//
//  Created by qingyun on 16/1/18.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "STabBarController.h"

@interface STabBarController ()

@end

@implementation STabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//封装思想：项目中有相同的功能，抽取一个类，封装好，自己做自己的事情。
-(void)setUpAllChildViewControllers
{
    //管理添加tabVC的子视图
    //1.home 首页
    UIViewController *home = [[UIViewController alloc]init];
    home.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:home];
    
    //2.message 信息
    UIViewController *message = [[UIViewController alloc]init];
    message.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:message];
    
    //3.discover 发现
    UIViewController *discover = [[UIViewController alloc]init];
    discover.view.backgroundColor = [UIColor grayColor];
    [self addChildViewController:discover];
    
    //4.profile 我
    UIViewController *profile = [[UIViewController alloc]init];
    profile.view.backgroundColor = [UIColor purpleColor];
    [self addChildViewController:profile];
}

@end
