//
//  SendStatusViewController.m
//  微博1508
//
//  Created by qingyun on 15/12/21.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "SendStatusViewController.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"

@interface SendStatusViewController ()<WBHttpRequestDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation SendStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)send:(id)sender {
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSString *token = app.token;
    //发布一条微博
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/update.json" httpMethod:@"POST" params:@{@"status":self.textView.text, @"access_token":token} delegate:self withTag:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)cancel:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result:%@", result);
}

-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response:%@", response);
}

-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error:%@", error);
}

@end
