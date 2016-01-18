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
