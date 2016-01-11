//
//  ZFTableViewController.m
//  房产展示
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "ZFTableViewController.h"
#import "ZFModel.h"
#import "ZFTableViewCell.h"
#import "AFNetworking.h"
#import "common.h"
#import "XQTableViewController.h"
#import "TJViewController.h"
#import "QYSelectedMenuModel.h"
#import "QYMainModel.h"
#import "QYSubModel.h"
#import "QYDropDownMenu.h"


@interface ZFTableViewController ()<UITableViewDataSource, UITableViewDelegate,QYDropDownMenuDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong)NSArray *array1;
@property(nonatomic, strong)NSArray *array2;
@property(nonatomic, strong)NSArray *array3;

@property (nonatomic, strong) QYDropDownMenu *dropDownMenu;//菜单
@property (nonatomic, strong)NSArray *selectedArray1;//区域 选中
@property (nonatomic, strong)NSArray *selectedArray2;//价格 选中
@property (nonatomic, strong)NSMutableArray *selectedArray3;//更多 选中
@property (nonatomic, strong)NSString *nid;
@property (nonatomic, strong)UIRefreshControl *refreshControl;//创建刷新控制器属性
@end

@implementation ZFTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requsetData];
    [self loadTJ];
    
//    self.refreshControl =[[UIRefreshControl alloc]init];
//    [self.refreshControl addTarget:self action:@selector(loadNew:) forControlEvents:UIControlEventValueChanged];
//    
//    self.refreshControl.attributedTitle = [self refreshControlTitleIWithString:@"下拉刷新"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom

-(NSAttributedString *)refreshControlTitleIWithString:(NSString *)title{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor grayColor]};
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    return string;
}

-(void)loadNew:(UIRefreshControl *)sender{
    NSLog(@"这就算刷新了");
}

//单独抽出一个停止刷新的方法
-(void)endrefresh{
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [self refreshControlTitleIWithString:@"正在刷新"];
}



#pragma mark -- 从网络请求租房信息
//请求数据
//HEAD_INFO={"commandcode":108,"REQUEST_BODY":{"city":"昆明","desc":"0" ,"p":1,"lat":24.973079315636,"lng":102.69840055824}}
-(void)requsetData{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];//创建管理者
    
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//请求的返回格式为text/html
    
    NSDictionary *params =@{@"HEAD_INFO" : @"{\"commandcode\":108,\"REQUEST_BODY\":{\"city\":\"昆明\",\"desc\":\"0\" ,\"p\":1,\"lat\":24.973079315636,\"lng\":102.69840055824}}"};
    
    [manger GET:QbaseUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"%@",responseObject);
        NSArray *listArr = responseObject[@"RESPONSE_BODY"][@"list"];// 取出需要的内容数组
//        NSLog(@"%@",listArr);
        
        //将从网络获得的数组转化成ZFmodel模型
        NSMutableArray *models = [NSMutableArray array];
             _ZFdatas = [NSMutableArray array];
        for (NSDictionary *dic in listArr) {
            ZFModel *model = [ZFModel modelWithDictionary:dic];
            [models addObject:model];
        }
        _ZFdatas = models;
    
        _refreshControl = [[UIRefreshControl alloc]init];
        
        [_refreshControl addTarget:self action:@selector(loadNew:) forControlEvents:UIControlEventValueChanged];
        
        _refreshControl.attributedTitle= [self refreshControlTitleIWithString:@"下拉刷新"];
        [self.tableView addSubview:_refreshControl];
        [self endrefresh];//这个结束刷新应该放到什么地方呢？
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    return _ZFdatas.count;
    return self.ZFdatas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZFcell" forIndexPath:indexPath];
    
    ZFModel *model = _ZFdatas[indexPath.row];
    
    cell.zfModel = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *stotyb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    XQTableViewController *xq = [stotyb instantiateViewControllerWithIdentifier:@"XQViewController"];
    [self.navigationController pushViewController:xq animated:YES ];
    
    ZFModel *zfmodel = [self.ZFdatas objectAtIndex:indexPath.row];//根据点击的indexPath.row 从转化的模型数组self.ZFdatas里面取出对应的模型。（核心是取出模型，另外记住此方法！）
    [xq setValue:zfmodel forKey:@"model"];
    
}

#pragma mark 点击按钮实现的功能
- (IBAction)btnClick:(UIButton *)sender {
    
    [self addDropDownMenu];
    switch (sender.tag) {
        case 101://区域
        {
            _dropDownMenu.datas = _array1;
            _dropDownMenu.menuType = QYDropDownMenuTypeDoubleColumnSingleSelection;
            _dropDownMenu.selectedRows = _selectedArray1;
        }
            break;
        case 102://价格
        {
            _dropDownMenu.datas = _array2;
            _dropDownMenu.menuType = QYDropDownMenuTypeSingleColumn;
            _dropDownMenu.selectedRows = _selectedArray2;
        }
            break;
        case 103://更多
        {
            _dropDownMenu.datas = _array3;
            _dropDownMenu.menuType = QYDropDownMenuTypeDoubleColumnMutSelection;
            _dropDownMenu.selectedRows = _selectedArray3;
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark 单表单选双表多选

-(NSMutableArray *)getArrayFromFile:(NSString *)filePath{
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *models = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        QYMainModel *mainModel = [QYMainModel modelWithDictionary:dict];
        [models addObject:mainModel];
    }
    return models;
}

#pragma mark -- 网络请求条件数据
-(void)loadTJ{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *params = @{@"HEAD_INFO" :@"{\"commandcode\":101,\"REQUEST_BODY\":{\"city\":\"昆明\"}}"};
    
    [manger GET:QbaseUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        
        NSArray *array = responseObject[@"RESPONSE_BODY"][@"list"];
//        NSLog(@"%@",array);
        //把网络获取的数据转化成模型
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYMainModel *mainModel = [QYMainModel modelWithDictionary:dict];
            [models addObject:mainModel];
        }
        _array1 = models;
        
        //价格数据
        _array2 = [self getArrayFromFile:[[NSBundle mainBundle] pathForResource:@"SiftZLP" ofType:@"plist"]];
        //更多数据
        _array3 = [self getArrayFromFile:[[NSBundle mainBundle] pathForResource:@"SiftZMore" ofType:@"plist"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark -- 点击选中主菜单
-(void)didSelectedMenuMainTableViewRow:(NSInteger)mainRow subTableView:(NSInteger)subRow{
    NSLog(@"mainRow:%ld,subRow:%ld",mainRow,subRow);
    QYSelectedMenuModel *selectedMenuModel = [QYSelectedMenuModel modelWithMainRow:mainRow subRow:subRow];
    switch (_dropDownMenu.menuType) {
        case QYDropDownMenuTypeSingleColumn://价格、单表
        {
            _selectedArray2 = @[selectedMenuModel];
        }
            break;
        case QYDropDownMenuTypeDoubleColumnMutSelection://更多、、、双表，多选
        {
            for (QYSelectedMenuModel *model in _selectedArray3) {
                if (model.mainRow == selectedMenuModel.mainRow) {
                    [_selectedArray3 removeObject:model];
                    break;
                }
            }
            [_selectedArray3 addObject:selectedMenuModel];
        }
            break;
        case QYDropDownMenuTypeDoubleColumnSingleSelection://区域、、、双表，单选
        {
            _selectedArray1 = @[selectedMenuModel];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark  --添加菜单
-(void)addDropDownMenu{
    QYDropDownMenu *menu = [[QYDropDownMenu alloc] initWithFrame:CGRectMake(0, 127, self.view.frame.size.width, 540)];
    [self.view addSubview:menu];
    _dropDownMenu = menu;
    //设置数据
    menu.datas = _array1;
    menu.menuType = QYDropDownMenuTypeDoubleColumnSingleSelection;
    //设置代理
    menu.delegate = self;
}

@end
