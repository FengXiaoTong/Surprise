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


-(void)loadXQ
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    NSDictionary *paras = @{@"HEAD_INFO" : @"{\"commandcode\":109,\"REQUEST_BODY\":{\"nid\":\"DCW001028\"}}"}; 由于每个租房的nid都不同，所以为了方便请求，选择字符串拼接！！！
    
    NSString *urlStr = [NSString stringWithFormat:@"{\"commandcode\":%d,\"REQUEST_BODY\":{\"nid\":\"%@\"}}",109,_model[@"nid"]];
    NSDictionary *paras = @{@"HEAD_INFO" :urlStr};
    
    [manger GET:QbaseUrl parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *xqArray = responseObject[@"RESPONSE_BODY"][@"list"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
