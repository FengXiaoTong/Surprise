//
//  StatusDetailViewController.m
//  微博MQ
//
//  Created by qingyun on 16/1/7.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "StatusDetailViewController.h"
#import "StatusTableViewCell.h"
#import "Status.h"
#import "statusFooterView.h"
#import "Common.h"
#import "Account.h"
#import "AFHTTPRequestOperationManager.h"
#import "Comment.h"
#import "CommentsCell.h"


@interface StatusDetailViewController ()

@property(nonatomic, strong)NSArray *commentsArray;

@end

@implementation StatusDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadComent];//请求评论数据
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -请求评论
-(void)loadComent{
    NSString *commentUrl = [kBaseUrl stringByAppendingPathComponent:@"/comments/show.json"];
    //请求的参数
    NSMutableDictionary *params = [[Account currentAccount]requests];
    [params setObject:self.status.statusId forKey:@"id"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:commentUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        //解析为model
        NSArray *resultArray = responseObject[@"comments"];
        NSMutableArray *commentSource =[NSMutableArray array];
        [resultArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Comment *comment = [[Comment alloc]initWithDictionary:obj];
            [commentSource addObject:comment];
        }];
        self.commentsArray = commentSource;
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //失败原因有
        //1.联网失败404
        //2.服务器端出错，不满足服务器限制条件
        //3.数据返回格式不对！
        NSLog(@"%@",error);
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }
    return self.commentsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        StatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
        [cell bandingStatus:self.status];
        
        return cell;
    }else{
        
        CommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"retwritterCell" forIndexPath:indexPath];
        [cell bangingComments:self.commentsArray[indexPath.row]];
        return cell;
    }
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return [StatusTableViewCell heightWithStatus:self.status];
    }else{
        //评论内容
        CommentsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"retwritterCell"];
        [cell bangingComments:self.commentsArray[indexPath.row]];
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height + 1;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }
    return 30.f;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    
    statusFooterView *footerView = [[[NSBundle mainBundle]loadNibNamed:@"StatusDetailHeaderView" owner:nil options:nil] objectAtIndex:0];
    [footerView bangingStatus:self.status];
    //给按钮添加点击事件
    [footerView.retwitterBtn addTarget:self action:@selector(headerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    footerView.retwitterBtn.tag = 1;
    
    [footerView.comment addTarget:self action:@selector(headerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    footerView.comment.tag = 2;
    
    [footerView.likeBtn addTarget:self action:@selector(headerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    footerView.likeBtn.tag = 3;
    
    return footerView;
    
}

//section header 上的按钮点击，出发的事件
-(void)headerButtonPress:(UIButton *)sender{
    statusFooterView *headerView =(statusFooterView *) [self.tableView headerViewForSection:1];
    [headerView selected:sender.tag];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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
