//
//  LoginViewController.m
//  微博MQ
//
//  Created by qingyun on 15/12/28.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "LoginViewController.h"
#import "Common.h"
#import "AFNetworking.h"
#import "Account.h"

@interface LoginViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView.delegate = self;
    //1.将用户引导到登录页面
    NSString * urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&response_type=code", kAppKey, kRedirect];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:request];
}
- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *loadUrl = request.URL;
    NSString *urlString = [loadUrl absoluteString];
    NSLog(@"%@",urlString);
    
    if ([urlString hasPrefix:kRedirect]) {
    
        NSArray *results = [urlString componentsSeparatedByString:@"code="];
        NSString *code = results.lastObject;
        
        //用code去换取access Token
        NSString *requestUrl = @"https://api.weibo.com/oauth2/access_token";
        
        NSDictionary *dictionary = @{@"client_id": kAppKey,
                                     @"client_secret":kAppSecret,
                                     @"grant_type":@"authorization_code",
                                     @"code":code,
                                     @"redirect_uri":kRedirect
                                     };
        AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
        
        manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
       
        [manger POST:requestUrl parameters:dictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            [[Account currentAccount ]saveLogin:responseObject];
        
            [self dismissViewControllerAnimated:YES completion:nil];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:kLoginSuccess object:nil];
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
        }];
    }
    return YES;

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
