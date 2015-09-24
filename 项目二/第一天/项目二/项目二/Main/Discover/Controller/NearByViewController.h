//
//  NearByViewController.h
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NearByViewController : BaseViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *_mapView;
    
    CLLocationManager *_locationManager;
    
}
@end
