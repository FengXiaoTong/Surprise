//
//  STabBarController.m
//  只用代码
//
//  Created by qingyun on 16/1/18.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "STabBarController.h"
#import "UIImage+SOriginal.h"

@interface STabBarController ()

@end

@implementation STabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildViewControllers];
}

#pragma mark -- 方法二选一
//加载类的时候调用 ，什么时候调用：程序一启动，就会把所有的类加载进内存
//+(void)load{
//    
//}


//什么时候调用：当第一次使用这个类或者子类的时候调用   作用：初始化类
//只要一个类遵守UIAppearance，那么就能获取全局的外观，UIView
+(void)initialize{
    
    //获取所有的tabBarItem,连系统的也一起获取，然后都改了
//    UITabBarItem *item = [UITabBarItem appearance];
    
    //获取当前这个类STabBarController下面所有的tabBarItem，self --->STabBarController  只改自己的，不改别人的（系统的）！
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *atts = [NSMutableDictionary dictionary];
    atts[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //[atts setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];等价于上面的
    [item setTitleTextAttributes:atts forState:UIControlStateSelected];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ---添加所以的视图控制器
//封装思想：项目中有相同的功能，抽取一个类，封装好，自己做自己的事情。
//继承于UIView的是控件，控件有颜色属性，继承于NSObject的是模型，模型用来保存数据,模型没有颜色属性！
//如果通过模型设置控件的文字颜色，只能通过文本属性（富文本：颜色，字体，空芯，文字阴影，图文混排）
-(void)setUpAllChildViewControllers
{
    //管理添加tabVC的子视图
    //1.home 首页
    UIViewController *home = [[UIViewController alloc]init];
    [self setUpOneChildViewControll:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    home.view.backgroundColor = [UIColor redColor];
   
    //2.message 信息
    UIViewController *message = [[UIViewController alloc]init];
    [self setUpOneChildViewControll:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"信息"];
    message.view.backgroundColor = [UIColor yellowColor];
    
    //3.discover 发现
    UIViewController *discover = [[UIViewController alloc]init];
    [self setUpOneChildViewControll:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    discover.view.backgroundColor = [UIColor grayColor];
   
    //4.profile 我
    UIViewController *profile = [[UIViewController alloc]init];
    [self setUpOneChildViewControll:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    profile.view.backgroundColor = [UIColor purpleColor];

}

#pragma mark -- 添加一个子视图控制器
-(void)setUpOneChildViewControll:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    vc.tabBarItem.badgeValue = @"15";
    [self addChildViewController:vc];

}

@end
