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
#import "QYDropDownMenu.h"


@interface ZFTableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) QYDropDownMenu *dropDownMenu;//菜单

@property(nonatomic, strong)NSArray *array1;
@property(nonatomic, strong)NSArray *array2;
@property(nonatomic, strong)NSArray *array3;


@property (nonatomic, strong) NSArray *selectedArray1;//区域选中
@property (nonatomic, strong) NSArray *selectedArray2;//价格选中
@property (nonatomic, strong) NSMutableArray *selectedArray3;//更多选中
@end

@implementation ZFTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self requsetData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//请求数据
//HEAD_INFO={"commandcode":108,"REQUEST_BODY":{"city":"昆明","desc":"0" ,"p":1,"lat":24.973079315636,"lng":102.69840055824}}
-(void)requsetData{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];//创建管理者
    
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//请求的返回格式为text/html
    
    NSDictionary *params =@{@"HEAD_INFO" : @"{\"commandcode\":108,\"REQUEST_BODY\":{\"city\":\"昆明\",\"desc\":\"0\" ,\"p\":1,\"lat\":24.973079315636,\"lng\":102.69840055824}}"};
    
    [manger GET:QbaseUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"%@",responseObject);
        NSArray *listArr = responseObject[@"RESPONSE_BODY"][@"list"];// 取出需要的内容数组
        
        //将从网络获得的数组转化成ZFmodel模型
        NSMutableArray *models = [NSMutableArray array];
             _ZFdatas = [NSMutableArray array];
        for (NSDictionary *dic in listArr) {
            ZFModel *model = [ZFModel modelWithDictionary:dic];
            [models addObject:model];
        }
        _ZFdatas = models;
    
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

//    return _datas.count;
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
}


- (IBAction)btnClick:(UIButton *)sender {
    
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
