//
//  ViewController.m
//  微博单点登陆
//
//  Created by qingyun on 15/12/26.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "ViewController.h"
#import "WeiboSDK.h"
#import "Common.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)login:(id)sender
{
    WBAuthorizeRequest *requset = [WBAuthorizeRequest request];
    requset.redirectURI = kRedirect;//设置回调地址
    requset.scope = @"all";
    
    [WeiboSDK sendRequest:requset];//发送请求
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
