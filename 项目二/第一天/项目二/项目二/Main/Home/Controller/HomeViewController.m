//
//  HomeViewController.m
//  项目二 - 微博
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "ThemeManager.h"
#import "WeiboModel.h"
#import "WeiboViewLayoutFrame.h"
#import "MJRefresh.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"
#import <AudioToolbox/AudioToolbox.h>

@interface HomeViewController () {
    NSMutableArray *_data;
    
    //弹出微博条数提示
    ThemeImageView *_barImageView;
    ThemeLabel *_barLabel;
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [[NSMutableArray alloc] init];

    //创建微博列表
    [self _createTableView];
    [self _loadWeiboData];
}
#pragma mark - tableView的创建
- (void) _createTableView{
    _weiboTable = [[WeiboTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.size.width, self.view.size.height)];
    
//    _weiboTable.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    _weiboTable.backgroundColor = [UIColor clearColor];
    //    _weiboTable.hidden = YES;
    
    [self.view addSubview:_weiboTable];
    
    //下拉刷新  
    _weiboTable.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewData)];
    //上啦获取更多数据
    _weiboTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
}

//获取微博数据的方法
- (void)_loadWeiboData{
    
    [self showHUD:@"正在加载"];
    
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //判断是否已经登陆
    if (appDelegate.sinaweibo.isLoggedIn) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"10" forKey:@"count"];
        
        //请求网络
//        [NSMutableDictionary dictionaryWithObject:appDelegate.sinaweibo.userID forKey:@"uid"]
       SinaWeiboRequest *request = [appDelegate.sinaweibo requestWithURL:home_timeline params:params
                                   httpMethod:@"GET"
                                     delegate:self];
        request.tag = 100;
        
        return;
    }
    
    [appDelegate.sinaweibo logIn];
}
//上啦刷新，获取更多微博
- (void)_loadMoreData{
    AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    //如果已经登陆则获取微博数据
    if (appDelegate.sinaweibo.isLoggedIn) {
        
        //params处理
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"10" forKey:@"count"];
        
        //设置maxId
        
        if (_data.count != 0) {
            WeiboViewLayoutFrame *layoutFrame = [_data lastObject];
            WeiboModel *model = layoutFrame.weiboModel;
            NSString *maxId = model.weiboIdStr;
            [params setObject:maxId forKey:@"max_id"];
        }
        
        SinaWeiboRequest *request = [appDelegate.sinaweibo requestWithURL:home_timeline
                                                                   params:params
                                                               httpMethod:@"GET"
                                                                 delegate:self];
        request.tag = 101;

        return;
    }
    [appDelegate.sinaweibo logIn];
    
}

//下啦刷新，获取最新微博
- (void)_loadNewData{
    
    AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (appDelegate.sinaweibo.isLoggedIn) {
        //params处理
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"10" forKey:@"count"];
        //设置 sinceId
        if (_data.count != 0) {
            WeiboViewLayoutFrame *layoutFrame = _data[0];
            WeiboModel *model = layoutFrame.weiboModel;
            NSString *sinceId = model.weiboIdStr;
            [params setObject:sinceId forKey:@"since_id"];
        }
        
        SinaWeiboRequest *request = [appDelegate.sinaweibo requestWithURL:home_timeline
                                                                   params:params
                                                               httpMethod:@"GET"
                                                                 delegate:self];
        request.tag = 102;
    
        return;
    }
    [appDelegate.sinaweibo logIn];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求代理方法
//- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response;
//- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data;
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{

}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
//    _weiboTable.hidden = NO;
//    NSLog(@"%@",result);
    //每一条微博存到 数组里
    NSArray *dicArray = [result objectForKey:@"statuses"];
    
    NSMutableArray *layoutFrameArray = [[NSMutableArray alloc] initWithCapacity:dicArray.count];
 
    //解析model
    for (NSDictionary *dataDic  in dicArray) {
        WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dataDic];
        
        WeiboViewLayoutFrame *layoutFrame = [[WeiboViewLayoutFrame alloc] init];
        layoutFrame.weiboModel = model;
        
        [layoutFrameArray addObject:layoutFrame];
    }
    
    if (request.tag == 100) {//普通加载微博
        _data = layoutFrameArray;
//        [self hideHUD];
        [self completeHUD:@"加载完成"];
        
    }else if(request.tag == 101){//更多微博
        
        if (layoutFrameArray.count > 1) {
            [layoutFrameArray removeObjectAtIndex:0];
            [_data addObjectsFromArray:layoutFrameArray];
        }
    }else if(request.tag == 102){//最新微博
        if (layoutFrameArray.count > 0) {
            
            NSRange range = NSMakeRange(0, layoutFrameArray.count);
            
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            
            [_data insertObjects:layoutFrameArray atIndexes:indexSet];
            
            [self showNewWeiboCount:layoutFrameArray.count];
        }
    }
    if (_data.count != 0) {
        _weiboTable.layoutFrameArray = _data;
        [_weiboTable reloadData];
    }
    
    [_weiboTable.header endRefreshing];
    [_weiboTable.footer endRefreshing];
    //将dataArray交给table
//    _weiboTable.dataArray = dataArray;
    
//    _weiboTable.layoutFrameArray = layoutFrameArray;
//    //获取数据后刷新表视图
//    [_weiboTable reloadData];

}
//下拉刷新时调用
- (void)showNewWeiboCount:(NSInteger)count{
    if (_barImageView == nil) {
        _barImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(5, -40, kScreenWidth-10, 40)];
        _barImageView.imgName = @"timeline_notify.png";
        [self.view addSubview:_barImageView];
        
        _barLabel = [[ThemeLabel alloc] initWithFrame:_barImageView.bounds];
        _barLabel.colorName = @"Timeline_Notice_color";
        _barLabel.backgroundColor = [UIColor clearColor];
        _barLabel.textAlignment = NSTextAlignmentCenter;
        
        [_barImageView addSubview:_barLabel];
    }
    //当有微博更新时显示
    if (count > 0) {
        _barLabel.text = [NSString stringWithFormat:@"更新了%li条微博",count];
        
        [UIView animateWithDuration:0.6 animations:^{
            _barImageView.transform = CGAffineTransformMakeTranslation(0, 64+5+40);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.6 animations:^{
                //延迟一秒
                [UIView setAnimationDelay:1];
                _barImageView.transform = CGAffineTransformIdentity;
            }];
        }];
        
        //播放声音
        NSString *path = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        //注册系统声音
        SystemSoundID soundId;
        AudioServicesCreateSystemSoundID((__bridge  CFURLRef)url, &soundId);//桥接
        
        //播放
        AudioServicesPlaySystemSound(soundId);
    }
}
@end
