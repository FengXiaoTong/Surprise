//
//  XQTableViewController.m
//  房产展示
//
//  Created by qingyun on 16/1/10.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//  这是房屋详细信息界面里面有好多个cell！！！

#import "XQTableViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "common.h"
#import "ZFTableViewController.h"
#import "ZFModel.h"
#import "XQModel.h"
#import "XQTableViewCell1.h"
#import "XQTableViewCell2.h"

@interface XQTableViewController ()
@property (nonatomic, strong)NSArray *nids;
@property (nonatomic, strong)NSArray *xqdatas;
@property (nonatomic, strong)ZFModel *model;

@end

@implementation XQTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadXQ];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
 
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

#pragma mark -- 从网络请求租房详细信息
-(void)loadXQ
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    NSDictionary *paras = @{@"HEAD_INFO" : @"{\"commandcode\":109,\"REQUEST_BODY\":{\"nid\":\"DCW001028\"}}"}; 由于每个租房的nid都不同，所以为了方便请求，选择字符串拼接！！！
    
//    NSString *urlStr = [NSString stringWithFormat:@"{\"commandcode\":%d,\"REQUEST_BODY\":{\"nid\":\"%@\"}}",109,self.model[@"nid"]];//记清楚，这里你定义的model是从前面模型数组里取出来赋值给的 模型，不是字典，所有不能用[@""]取值
    
        NSString *urlStr = [NSString stringWithFormat:@"{\"commandcode\":%d,\"REQUEST_BODY\":{\"nid\":\"%@\"}}",109,self.model.nid];// model是模型，模型取值，直接打点取值！！！
    NSDictionary *paras = @{@"HEAD_INFO" :urlStr};
    
    [manger GET:QbaseUrl parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        XQTableViewCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"XQcell1" forIndexPath:indexPath];
    
         return cell1;
        
    }else if (indexPath.row == 1) {
              XQTableViewCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"XQcell2" forIndexPath:indexPath];
        
            return cell2;
        }
    
    return nil;
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
