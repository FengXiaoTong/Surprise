//
//  HomeVC.m
//  微博MQ
//
//  Created by qingyun on 15/12/30.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "HomeVC.h"
#import "AFHTTPRequestOperationManager.h"
#import "Account.h"
#import "Common.h"
#import "StatusTableViewCell.h"
#import "Status.h"
#import "dataBase.h" 

@interface HomeVC ()<UITableViewDataSource,UITableViewDelegate>

//@property(nonatomic, strong)NSArray *statuses;//请求到的微博数据
@property (nonatomic, strong)NSMutableArray *statuses;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadData];//有数据库后，就直接取数据库中的内容就好。不用去刷新数据
    self.statuses = [NSMutableArray arrayWithArray:[dataBase getStatusFromDB]]; //直接从本地取数据，更快！
}

-(NSMutableArray *)statuses
{
    if (!_statuses) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

-(void)loadData
{
    NSString *urlString = [kBaseUrl stringByAppendingPathComponent:@"statuses/home_timeline.json"];
    
    NSMutableDictionary *mdictionary = [[Account currentAccount]requests];
    if (!mdictionary) {
        return;
    }
    
    [mdictionary setObject:@100 forKey:@"count"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:mdictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // NSLog(@"%@",responseObject);
//        self.statuses = responseObject[@"statuses"];
        NSArray *result = responseObject[@"statuses"];
        [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Status *status = [[Status alloc]initStatusWithDictionary:obj];
            [self.statuses addObject:status];
            
        }];
        [self.tableView reloadData];
        
//        NSLog(@"%@",[dataBase class]);
        [dataBase saveStatus:result];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     StatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
    
    [cell bandingStatus:self.statuses[indexPath.row]];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //计算出cell的高度
//    StatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell"];
//    
//    [cell bandingStatus:self.statuses[indexPath.row]];
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    
//    return size.width +1;
    NSDictionary *info = self.statuses[indexPath.row];
    return [StatusTableViewCell heightWithStatus:info];
    
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
