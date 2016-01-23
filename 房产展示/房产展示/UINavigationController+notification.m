//
//  UINavigationController+notification.m
//  微博MQ
//
//  Created by qingyun on 16/1/7.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "UINavigationController+notification.h"
#import "Common.h"

@implementation UINavigationController (notification)

-(void)showNotification:(NSString *)string
{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, kAppSCreenBounds.size.width, 44)];
    label1.text = string;
    label1.backgroundColor = [UIColor orangeColor];
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    
     //把label作为navigationViewController的subView，并且在navigationBar的上面
    [self.view insertSubview:label1 belowSubview:self.navigationBar];
    //把label作为navigationViewController的subView，并且在navigationBar的下面
//    [self.view insertSubview:label1 aboveSubview:self.navigationBar];
    [UIView animateWithDuration:0.4 animations:^{
        
        label1.frame = CGRectOffset(label1.frame, 0, 44);
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.65 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.44 animations:^{
                
                label1.frame = CGRectOffset(label1.frame, 0, -44);
            } completion:^(BOOL finished) {
                [label1 removeFromSuperview];
           }];
        });
    }];

}

@end
