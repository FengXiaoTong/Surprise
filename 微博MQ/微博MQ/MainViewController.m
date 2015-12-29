//
//  MainViewController.m
//  微博MQ
//
//  Created by qingyun on 15/12/28.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "MainViewController.h"
#import "Account.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if (![[Account currentAccount]isLogin]) {
        self.selectedIndex = 3;
    }
    //设置未登录状态默认选择第三个控制器
    
    self.tabBar.tintColor = [UIColor orangeColor];
    
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
