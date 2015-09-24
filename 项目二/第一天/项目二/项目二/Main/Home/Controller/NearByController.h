//
//  NearByController.h
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface NearByController : BaseViewController <UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>

{
    UITableView *_tableView;
    
    CLLocationManager *_locationManager;
}
@property (nonatomic, strong) NSArray *data;
@end
