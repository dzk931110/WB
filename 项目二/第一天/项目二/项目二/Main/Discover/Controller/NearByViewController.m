//
//  NearByViewController.m
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "NearByViewController.h"
#import "WeiboAnnotation.h"
#import "WeiboAnnotationView.h"
#import "DataService.h"
#import "WeiboModel.h"
#import "DetailViewController.h"

@interface NearByViewController ()

@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];

    [self _createViews];
    [self _location];
    
//    WeiboAnnotation *annotation = [[WeiboAnnotation alloc] init];
//    annotation.title = @"title";
//    annotation.subtitle = @"subtitle";
//    CLLocationCoordinate2D coordinate = {30.2,120.2};
//    [annotation setCoordinate:coordinate];
//    [_mapView addAnnotation:annotation];
//    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//创建mapview
- (void)_createViews {
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    //显示用户位置
    _mapView.showsUserLocation = YES;
    
    _mapView.mapType = MKMapTypeStandard;
    
    _mapView.delegate = self;
    
//    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    [self.view addSubview:_mapView];
    
}
#pragma mark - mapview代理
//返回标注视图
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    
//    //如果是用户定位，则返回默认的标注视图
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
//    
//    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
//    if (pinView == nil) {
//        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
//        //设置大头针颜色
//        pinView.pinColor = MKPinAnnotationColorPurple;
//        //设置从天而降的动画
//        pinView.animatesDrop = YES;
//        //设置显示标题
//        pinView.canShowCallout = YES;
//        //设置辅助视图
////        pinView.rightCalloutAccessoryView;
//    }
//    
//    
//    return pinView;
//}
//自定义返回视图
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    //如果是用户定位，则返回默认的标注视图
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    if ([annotation isKindOfClass:[WeiboAnnotation class]]) {
        WeiboAnnotationView *annotationView = (WeiboAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
        if (annotationView == nil) {
            annotationView = [[WeiboAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];

        }
        annotationView.annotation = annotation;
        return annotationView;
    }
    
    return nil;
   
}


#pragma mark - 定位
- (void)_location{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        
        //版本判断
        if (kVersion > 8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    //定位精度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //设置代理
    _locationManager.delegate = self;
    //开始定位
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //停止定位
    [_locationManager stopUpdatingLocation];
    //取得地理位置信息
    CLLocation *location = [locations lastObject];
    //获取经纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    
    //请求数据
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    [self loadNearByPoisWithLon:lon Lat:lat];
    
    //设置center
    CLLocationCoordinate2D center = coordinate;
    //设置span,数值越小，经度越高，范围越小
    MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion region = {center,span};
    
    [_mapView setRegion:region];
    
}

//获取附近的微博
- (void)loadNearByPoisWithLon:(NSString *)lon Lat:(NSString *)lat{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    
    [DataService requestUrl:nearby_timeline httpMethod:@"GET" params:params block:^(id result) {
      
        NSArray *statuses = [result objectForKey:@"statuses"];
        NSMutableArray *annotationArray = [[NSMutableArray alloc] initWithCapacity:statuses.count];
        
        for (NSDictionary *dataDic  in statuses) {
            WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dataDic];
            
            //创建annotation
            WeiboAnnotation *annotation = [[WeiboAnnotation alloc] init];
            annotation.weiboModel = model;
            [annotationArray addObject:annotation];
        }
        //把annotation添加到mapview上
        [_mapView addAnnotations:annotationArray];
        
    }];
    
}
//标注视图被选中。点击，跳到微博详情
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if (![view.annotation isKindOfClass:[WeiboAnnotation class]]) {
        return;
    }
    
    WeiboAnnotation *weiboAnnotation = (WeiboAnnotation *)view.annotation;
    WeiboModel *weiboModel = weiboAnnotation.weiboModel;
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.weiboModel = weiboModel;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
