//
//  GuideViewController.m
//  微博MQ
//
//  Created by qingyun on 15/12/27.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"

@interface GuideViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation GuideViewController

-(void)dealloc
{
    NSLog(@"guide shifang");
}

- (IBAction)guide:(id)sender
{
    //引导页结束之后点击
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    [app guide]; 
}

- (void)viewDidLoad {
    
//    CGRect frame  = [UIScreen mainScreen].bounds;
//    
//    self.scrollView.contentSize = CGSizeMake(frame.size.width *4, frame.size.height);
    
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
