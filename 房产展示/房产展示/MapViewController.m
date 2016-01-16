//
//  MapViewController.m
//  房产展示
//
//  Created by qingyun on 16/1/15.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "AFNetworking.h"
#import "common.h"

@interface MapViewController ()<BMKMapViewDelegate>

@property (nonatomic,strong) BMKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求昆明在地图上信息
    [self loadJWdatas];
    //添加百度地图
    [self addBaiduMap];
   
}

#pragma mark -- 添加百度地图
-(void)addBaiduMap
{
    _mapView = [[BMKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_mapView setMapType:BMKMapTypeStandard];//用的是普通地图（不是卫星地图，可以设置的）
    
    //添加一个标注点
    BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coord;
    coord.latitude = 39.915;//经度
    coord.longitude = 116.404;//纬度
    annotation.coordinate = coord;
    _mapView.centerCoordinate = coord;//地图的中心点
    annotation.title = @"你猜这是哪";
    [_mapView addAnnotation:annotation];//地图上添加标注点
    
    BMKCircle *circle = [BMKCircle circleWithCenterCoordinate:coord radius:1000];//以标注点为中心，添加一个圆形区域
    
    [_mapView addOverlay:circle];//添加覆盖物
    
    _mapView.showMapScaleBar = YES;//设置比例尺显示
    
    [self.view addSubview:_mapView];
}


#pragma mark -- 释放内存
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    _mapView.delegate = self;// 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
     _mapView.delegate = nil;// 不用时，置nil
}

#pragma mark --这是BMKMapViewDelegate代理方法实现动画,标注自己跑出来！
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;
        return newAnnotationView;
    }
    //删除标注的方法
//    if (annotation != nil) {
//        [_mapView removeAnnotation:annotation];
//    }
    return nil;
}

#pragma mark ---网络请求昆明在地图上的位置信息
//HEAD_INFO={"commandcode":122,"REQUEST_BODY":{"city":"昆明","minlat":24.651335,"maxlat":25.303114,"minlng":102.489643
-(void)loadJWdatas{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *params =@{@"HEAD_INFO" : @"{\"commandcode\":122,\"REQUEST_BODY\":{\"city\":\"昆明\",\"minlat\":24.651335,\"maxlat\":25.303114,\"minlng\":102.489643}}"};
    [manger GET:QbaseUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
