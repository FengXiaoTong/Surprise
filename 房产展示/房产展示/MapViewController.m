//
//  MapViewController.m
//  房产展示
//
//  Created by qingyun on 16/1/15.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <UIKit/UIKit.h>

@interface MapViewController ()<BMKMapViewDelegate>
@property (strong, nonatomic) IBOutlet BMKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_mapView setMapType:BMKMapTypeStandard];//用的是普通地图（不是卫星地图，可以设置的）
    [self.view addSubview:_mapView];
    
    //添加一个标注点
    BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coord;
    coord.latitude = 12.3239;
    coord.latitude = 22.2320;
    annotation.coordinate = coord;
    annotation.title = @"你猜这是哪";
    [_mapView addAnnotation:annotation];//地图上添加标注点
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
