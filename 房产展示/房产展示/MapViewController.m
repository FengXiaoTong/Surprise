//
//  MapViewController.m
//  房产展示
//
//  Created by qingyun on 16/1/15.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong)CLLocationManager *locationManger;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong)id<MKAnnotation> point;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManger = [[CLLocationManager alloc]init];
    self.locationManger.delegate = self;
    
    if ([CLLocationManager authorizationStatus]== kCLAuthorizationStatusNotDetermined) {
        
        [self.locationManger requestAlwaysAuthorization];
    }
    
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManger startUpdatingLocation];
    }else{
        NSLog(@"GPS未打开");
    }
    
}


-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusDenied) {
        NSLog(@">>>用户不允许使用GPS");
    }else if (status == kCLAuthorizationStatusRestricted){
        NSLog(@"<<<<GPS暂无法使用");
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
