//
//  FindViewController.m
//  微博MQ
//
//  Created by qingyun on 15/12/29.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "FindViewController.h"
#import "Account.h"

@interface FindViewController ()

@property(nonatomic, strong)UIBarButtonItem *right;

@end

@implementation FindViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[Account currentAccount]isLogin]) {
        
        self.right = self.navigationItem.rightBarButtonItem;//先给它一个指针地址，否则为空，直接炸
        self.navigationItem.rightBarButtonItem = nil;//登陆状态下，登陆barButtonItem 消失
    }else{
        //没有账号登陆
        if (self.right) {
            //那就让self.navigationItem.rightBarButtonItem 显示出来“登录”俩字
            self.navigationItem.rightBarButtonItem = self.right;
        }
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
