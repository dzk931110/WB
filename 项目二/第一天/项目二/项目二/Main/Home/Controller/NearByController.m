//
//  NearByController.m
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "NearByController.h"
#import "ThemeButton.h"
#import "DataService.h"
#import "NearModel.h"
#import "UIImageView+WebCache.h"

@interface NearByController ()

@end

@implementation NearByController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self _createNav];
    [self createTable];
    
    //定位
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
- (void)createTable {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}
#pragma mark - location 代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //停止定位
    [manager stopUpdatingLocation];
    
    //获取当前请求的位置
    CLLocation *location = [locations lastObject];
    NSString *lon = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    
    //开启网络加载
    [self loadNearByPoisWithLon:lon Lat:lat];
}
- (void)loadNearByPoisWithLon:(NSString *)lon Lat:(NSString *)lat{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:@50 forKey:@"count"];
    
    [DataService requestUrl:nearby_pois httpMethod:@"GET" params:params block:^(id result) {
        NSArray *pois = result[@"pois"];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in pois) {
            NearModel *nearModel = [[NearModel alloc] initWithDataDic:dic];
            [array addObject:nearModel];
        }
        _data = array;
        [_tableView reloadData];
    }];

}
#pragma mark - tableview代理 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    NearModel *nearModel = _data[indexPath.row];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:nearModel.icon] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    cell.textLabel.text = nearModel.title;
    
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//创建导航栏关闭按钮
- (void)_createNav {

    ThemeButton *closeButton = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    closeButton.normalImageName = @"button_icon_close.png";
    [closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    
    self.navigationItem.leftBarButtonItem = button;
}
//导航栏关闭按钮动作响应
- (void)closeAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
