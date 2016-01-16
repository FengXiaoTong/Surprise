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
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
