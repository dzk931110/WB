//
//  DetailViewController.m
//  项目二
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "DetailViewController.h"
#import "MJRefresh.h"
#import "CommentModel.h"
#import "AppDelegate.h"

@interface DetailViewController (){
    SinaWeiboRequest *_request;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _createViews];
    [self _loadData];
}
//初始化
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"微博详情";
    }
    return self;
}
//初始化
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"微博详情";
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    self.view.backgroundColor = [UIColor clearColor];
}
- (void)viewWillDisappear:(BOOL)animated{
    //当界面弹出的时候，断开网络链接
    [_request disconnect];
}

//创建表视图
- (void)_createViews{
    _commentTableView = [[CommentTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _commentTableView.weiboModel = self.weiboModel;
    
    _commentTableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_commentTableView];
    
    _commentTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//加载数据
- (void)_loadData{
    
//    NSString *weiboId = [self.weiboModel.weiboId stringValue];
    NSString *weiboId = self.weiboModel.weiboIdStr;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:weiboId forKey:@"id"];
    
    SinaWeibo *sinaWeibo = [self sinaweibo];
    _request =  [sinaWeibo requestWithURL:comments params:params httpMethod:@"GET" delegate:self];
    _request.tag = 100;
    
}
//加载更多数据
- (void)_loadMoreData{
    NSString *weiboId = [self.weiboModel.weiboId stringValue];
//    NSString *weiboId = self.weiboModel.weiboIdStr;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:weiboId forKey:@"id"];
    
    //设置max_id 分页加载
    CommentModel *cm = [self.data lastObject];
    if (cm == nil) {
        return;
    }
    NSString *lastID = cm.idstr;
    [params setObject:lastID forKey:@"max_id"];
    
    
    SinaWeibo *sinaWeibo = [self sinaweibo];
    _request =  [sinaWeibo requestWithURL:comments params:params httpMethod:@"GET" delegate:self];
    _request.tag = 102;
}
- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    NSLog(@"网络接口 请求成功");
    
    NSArray *array = [result objectForKey:@"comments"];
    
    NSMutableArray *comentModelArray = [[NSMutableArray alloc] initWithCapacity:array.count];
    
    for (NSDictionary *dataDic in array) {
        CommentModel *commentModel = [[CommentModel alloc]initWithDataDic:dataDic];
        [comentModelArray addObject:commentModel];
    }
    
    
    if (request.tag == 100) {
        self.data = comentModelArray;
        
    }else if(request.tag ==102){//更多数据
        [_commentTableView.footer endRefreshing];
        if (comentModelArray.count > 1) {
            [comentModelArray removeObjectAtIndex:0];
            [self.data addObjectsFromArray:comentModelArray];
        }else{
            return;
        }
    }
    
    //传值
    _commentTableView.commentDataArray = self.data;
    _commentTableView.commentDic = result;
    [_commentTableView reloadData];
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
