//
//  ZYJLTableViewController.m
//  20160328
//
//  Created by runsheng on 16/3/29.
//  Copyright © 2016年 runsheng. All rights reserved.
//

#import "ZYJLTableViewController.h"
#import "ZYTabBarController.h"

@interface ZYJLTableViewController ()
@property(nonatomic, strong)NSArray* datas;
@end

@implementation ZYJLTableViewController

- (void)viewDidLoad{
      [super viewDidLoad];
      self.tableView.delegate = self;
      self.tableView.dataSource = self;
      self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(NSArray *)datas
{
    if (_datas == nil) {
        _datas = @[@"简历名称",@"求职意向",@"工作经历",@"教育背景",@"项目经验",@"自我描述",@"其他"];
    }
    return _datas;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
                           }
    cell.textLabel.text = self.datas[indexPath.row];
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated:YES];   //点击效果动画消失
    switch (indexPath.row) {
        case 0:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        } case 1:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        } case 2:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        } case 3:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        }case 4:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        }case 5:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        }case 6:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        }
            
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 160;
                                            }
        return 40;
}
@end
