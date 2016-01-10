//
//  TJViewController.m
//  房产展示
//
//  Created by qingyun on 16/1/10.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "TJViewController.h"
#import "common.h"
#import "AFHTTPRequestOperationManager.h"
#import "QYMainModel.h"
#import "QYSubModel.h"
#import "QYDropDownMenu.h"
#import "QYSelectedMenuModel.h"
@class QYDropDownMenu;
@interface TJViewController ()<QYDropDownMenuDelegate>

@property(nonatomic, strong)NSArray *array1;
@property(nonatomic, strong)NSArray *array2;
@property(nonatomic, strong)NSArray *array3;

@property (nonatomic, strong) QYDropDownMenu *dropDownMenu;//菜单

@property (nonatomic, strong) NSArray *selectedArray1;//区域选中
@property (nonatomic, strong) NSArray *selectedArray2;//价格选中
@property (nonatomic, strong) NSMutableArray *selectedArray3;//更多选中
@end

@implementation TJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    _selectedArray3 = [NSMutableArray array];
    
    [self loadTJ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



-(NSMutableArray *)getArrayFromFile:(NSString *)filePath{
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *models = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        QYMainModel *mainModel = [QYMainModel modelWithDictionary:dict];
        [models addObject:mainModel];
    }
    return models;
}

-(void)loadTJ{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *params = @{@"HEAD_INFO" :@"{\"commandcode\":101,\"REQUEST_BODY\":{\"city\":\"昆明\"}}"};
    
    [manger GET:QbaseUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        NSArray *array = responseObject[@"RESPONSE_BODY"][@"list"];
        NSLog(@"%@",array);
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
        
         [self addDropDownMenu];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
   
    
}


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

-(void)addDropDownMenu{
    QYDropDownMenu *menu = [[QYDropDownMenu alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 400)];
    [self.view addSubview:menu];
    _dropDownMenu = menu;
    //设置数据
    menu.datas = _array1;
    menu.menuType = QYDropDownMenuTypeDoubleColumnSingleSelection;
    //设置代理
    menu.delegate = self;
}



@end
