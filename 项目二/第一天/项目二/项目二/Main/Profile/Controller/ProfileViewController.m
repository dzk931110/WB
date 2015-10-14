//
//  ProfileViewController.m
//  项目二 - 微博
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "MyModel.h"

@interface ProfileViewController () <SinaWeiboRequestDelegate>
{
    SinaWeiboRequest *_request;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    [self _createViews];
    [self _loadData];
    
}
- (void)_createViews {
    _tableView = [[MyTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
 
}
- (void)_loadData {

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:@"10" forKey:@"count"];
    
    SinaWeibo *sinaWeibo = [self sinaWeibo];
    
    _request = [sinaWeibo requestWithURL:user_timeline params:params httpMethod:@"GET" delegate:self];
    _request.tag = 101;
}
//加载更多数据
- (void)loadMoreData{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    MyModel *weiboModel = [[MyModel alloc] init];
//    weiboModel = [_data lastObject];
//    NSString *weiboid = weiboModel.weiboIdStr;
//    
//    [params setObject:weiboid forKey:@"max_id"];
    
    SinaWeibo *sinaWeibo = [self sinaWeibo];
    _request =  [sinaWeibo requestWithURL:user_timeline params:params httpMethod:@"GET" delegate:self];
    _request.tag = 102;
}
- (SinaWeibo *)sinaWeibo{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.sinaweibo;
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
//    NSLog(@"reslut = %@",result);
    
    NSArray *array = [result objectForKey:@"statuses"];
    NSMutableArray *weiboArray = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        MyModel *myModel = [[MyModel alloc] initWithDataDic:dic];
        [weiboArray addObject:myModel];
    }
    
    if (request.tag == 101) {
        self.data = weiboArray;
    }else if(request.tag == 102) {
        [_tableView.footer endRefreshing];
        if (weiboArray.count > 1) {
            [weiboArray removeObjectAtIndex:0];
            [self.data addObjectsFromArray:weiboArray];
        }else {
            return;
        }
    }
    _tableView.dataArray = self.data;
    _tableView.dic = result;
    
    [_tableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
