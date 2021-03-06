//
//  SettingViewController.m
//  微博MQ
//
//  Created by qingyun on 15/12/29.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "SettingViewController.h"
#import "Account.h"
#import "UITableView+index.h"
#import "MainViewController.h"
#import "SDImageCache.h"

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)NSArray *cellTitle;

@end


@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[Account currentAccount]isLogin]) {
        // 显示状态登录的信息
        self.cellTitle = @[@[@"账号管理"],@[@"通知",@"隐私与安全",@"通用设置"],@[@"清理缓存",@"意见反馈",@"关于微博"],@[@"退出微博账号"]];
    }else{
        self.cellTitle = @[@[@"通用设置"], @[@"关于微博"]];
    }
}



#pragma mark --- delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellTitle.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.cellTitle[section] count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//        static NSString *identifier = @"cell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (cell==nil) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        }
    
    if (indexPath.section == 3 && indexPath.row == 0) {
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.textLabel.text = @"退出当前登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.cellTitle[indexPath.section][indexPath.row];
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f M",[[SDImageCache sharedImageCache]getSize]/1024.f/1024.f];
    }else{
        cell.detailTextLabel.text = nil;
    }
    return cell;

}

//点击cell可以做的事
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [tableView initWithIndexPath:indexPath];
    
    switch (index) {
        case 7:{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                   //退出当前账号
                [self.navigationController popViewControllerAnimated:YES];//默认退出到上一界面  如果需要跳转到指定页面，就需要另外的方法，需要给它一个指定的跳转控制器
                
                //清理物理文件中保存的账号信息和内存  先清理数据，再修改UI
                [[Account currentAccount] logout];
                
                UIWindow *window = [[[UIApplication sharedApplication]delegate]window];
                MainViewController *main = (MainViewController *)window.rootViewController;
                [main logout];//退出账号，跳转到登录界面
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            [alert addAction:action];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
            break;
            
        case 4:
        {
            //清除缓存的工作
            [[SDImageCache sharedImageCache] clearDisk];
            [tableView reloadData];
        }
            break;
            
        default:
            break;
    }
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
