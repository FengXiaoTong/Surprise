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
#import "UINavigationController+notification.h"

typedef enum :  NSUInteger{
    kLoadDefault,//基本的加载
    kLoadNew,//加载更新的数据
    kLoadMore//加载更多的数据
}StatusLoadType;


@interface HomeVC ()<UITableViewDataSource,UITableViewDelegate>

//@property(nonatomic, strong)NSArray *statuses;//请求到的微博数据
@property (nonatomic, strong)NSMutableArray *statuses;

//@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property(nonatomic )BOOL loading;//判断是否正在加载的状态
@property(nonatomic )BOOL loadMoreEnd;//加载更多结束的判断
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
    
    //添加下来刷新的控件
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(loadNew:) forControlEvents:UIControlEventValueChanged];

    self.refreshControl.attributedTitle = [self refreshControlTitleIWithString:@"下拉刷新"];//设置refreshControl的标题为 下拉刷新
}

-(NSMutableArray *)statuses
{
    if (!_statuses) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}


//从服务器加载数据
-(void)loadData
{
    
    [self loadDataWithType:kLoadDefault];
    
//    NSString *urlString = [kBaseUrl stringByAppendingPathComponent:@"statuses/home_timeline.json"];
//    
//    NSMutableDictionary *mdictionary = [[Account currentAccount]requests];
//    if (!mdictionary) {
//        return;
//    }
//    
//    [mdictionary setObject:@100 forKey:@"count"];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:urlString parameters:mdictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        // NSLog(@"%@",responseObject);
////        self.statuses = responseObject[@"statuses"];
//        NSArray *result = responseObject[@"statuses"];
//        
//        [self.statuses removeAllObjects];//清楚掉从数据库中缓存（查询到）的数据
//        [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            Status *status = [[Status alloc]initStatusWithDictionary:obj];
//            [self.statuses addObject:status];
//            
//        }];
//        [self.tableView reloadData];
//        
////        NSLog(@"%@",[dataBase class]);
//        [dataBase saveStatus:result];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//        
//    }];
}

#pragma mark - custom

-(NSAttributedString *)refreshControlTitleIWithString:(NSString *)title{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor grayColor]};
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    return string;
}


//三和一加载方法
-(void)loadDataWithType:(StatusLoadType )loadType{
    
    //1.url地址
    NSString *urlString = [kBaseUrl stringByAppendingPathComponent:@"statuses/home_timeline.json"];
    //2.基本请求参数
    NSMutableDictionary *params = [[Account currentAccount]requests];
    switch (loadType) {
        case kLoadNew:
        {
            [params setObject:[self.statuses.firstObject statusId] forKey:@"since_id"];
        }
            break;
        case kLoadMore:
        {
            [params setObject:[self.statuses.lastObject statusId] forKey:@"max_id"];
        }
            break;
        
        default:
            break;
    }
    //加载更多完成
    if (loadType == kLoadMore && self.loadMoreEnd) {
        return;
    }
    //正在进行加载，不进行新的加载
    if (self.loading) {
        return;
    }
    self.loading = YES;
    //进行网络请求
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

        //model数组
        NSMutableArray *result = [NSMutableArray array];
        //json数组
        NSArray *statusArray = responseObject[@"statuses"];
        [statusArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Status *status = [[Status alloc]initStatusWithDictionary:obj];
            [result addObject:status];
        }];
        
        if (loadType == kLoadNew) {
            
            //将转化的模型，整体插入到数组的最前面
            [self.statuses insertObjects:result atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.count)]];
            
            //通知用户刷新了多少条数据
            [self.navigationController showNotification:[NSString stringWithFormat:@"更新了%ld条微博",result.count]];
            
            [self endrefresh];//刷新完tableView后，结束刷新（菊花）
            
        }else{
            [self.statuses addObjectsFromArray:result];
        }
        [self.tableView reloadData];//刷新tableView
        
        //默认加载20条,如果上滑加载的不够20条，说明到底了,加载更多完成
        if (loadType == kLoadMore && statusArray.count < 20) {
            self.loadMoreEnd = YES;
        }
        
        self.loading = NO;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        self.loading = NO;
    }];
}



-(void)loadNew:(UIRefreshControl *)sender{
    
    self.refreshControl.attributedTitle = [self refreshControlTitleIWithString:@"正在刷新"];
    
    [self loadDataWithType:kLoadNew];
//
//    //加载更新的方法
//    NSMutableDictionary *dic = [[Account currentAccount]requests];
//    if (!dic) {
//        //未登陆
//        [self endrefresh];//在return之前刷新
//        return;
//        
//    }
//    //请求参数
//    [dic setObject:[self.statuses.firstObject statusId] forKey:@"since_id"];
//    //url地址
//    NSString *urlStr = [kBaseUrl stringByAppendingPathComponent:@"statuses/home_timeline.json"];
//    
//    //数据请求
//    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
//    [manger GET:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"刷新了%ld条数据",[responseObject[@"statuses"]count]);
//        
//        //model数组
//        NSMutableArray *result = [NSMutableArray array];
//        //json数组
//        NSArray *statusArray = responseObject[@"statuses"];
//        [statusArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            Status *status = [[Status alloc]initStatusWithDictionary:obj];
//            [result addObject:status];
//        }];
//        //将转化的模型，整体插入到数组的最前面
//        [self.statuses insertObjects:result atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.count)]];
//        
//        [self.tableView reloadData];//刷新tableView
//        
//        //通知用户刷新了多少条数据
//        [self.navigationController showNotification:[NSString stringWithFormat:@"更新了%ld条微博",result.count]];
//        
//        [self endrefresh];//刷新完tableView后，结束刷新（菊花）
//       
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"%@",error);
//        
//        [self endrefresh];
//        
//    }];
//    
}

//单独抽出一个停止刷新的方法
-(void)endrefresh{
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [self refreshControlTitleIWithString:@"还在刷新中"];
}

-(void)loadMore
{
    
    [self loadDataWithType:kLoadMore];
//    //提交参数
//    NSMutableDictionary *params =[[Account currentAccount]requests];
//    [params setObject:[self.statuses.lastObject statusId] forKey:@"max_id"];
//    
//    NSString *urlString = [kBaseUrl stringByAppendingPathComponent:@"statuses/home_timeline.json"];
//    
//    if (self.loading || self.loadMoreEnd) {
//        return;
//    }
//     self.loading = YES;
//    
//    AFHTTPRequestOperationManager *manger =[AFHTTPRequestOperationManager manager];
//    [manger GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSArray *statusArray = responseObject[@"statuses"];
//        
//        //默认加载20条,如果上滑加载的不够20条，说明到底了。
//        if (statusArray.count < 20) {
//            self.loadMoreEnd = YES;
//        }
//        NSLog(@"加载了%ld条数据",statusArray.count);
//        [statusArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            Status *status = [[Status alloc]initStatusWithDictionary:obj];
//            //加载到现有的数据源的最后
//            [self.statuses addObject:status];
//        }];
//        //先更新数据，在刷新UI
//        [self.tableView reloadData];
//        
//        self.loading = NO;
//    
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        self.loading = NO;
//    }];
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
    Status *info = self.statuses[indexPath.row];
    return [StatusTableViewCell heightWithStatus:info];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //index那行将要显示
    //进行加载更多的操作,条件（下拉滑到倒数第五条，可以进行加载更多）
    if (self.statuses.count - indexPath.row <= 5) {
        [self loadMore];
    }
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
