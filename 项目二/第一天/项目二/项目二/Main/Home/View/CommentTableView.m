//
//  CommentTableView.m
//  项目二
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "CommentTableView.h"
#import "WeiboViewLayoutFrame.h"

@implementation CommentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _createHeadView];
        
        self.delegate = self;
        self.dataSource = self;
        
        //注册cell，从xib文件创建
        UINib *nib = [UINib nibWithNibName:@"CommentCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:@"cell"];
        
    }
    
    return self;
    
}
#pragma mark - 创建头视图
- (void)_createHeadView{
    //创建父视图
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
    _headView.backgroundColor = [UIColor clearColor];
    
    //创建用户视图，使用xib文件
    _userView = [[[NSBundle mainBundle] loadNibNamed:@"UserView" owner:self options:nil] lastObject];
    _userView.backgroundColor = [UIColor clearColor];
    _userView.width = kScreenWidth;
    _userView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    [_headView addSubview:_userView];
    
    //创建微博视图
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _weiboView.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_headView addSubview:_weiboView];
}
- (void)setWeiboModel:(WeiboModel *)weiboModel{
    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
        
        
        //1.创建微博视图的布局对象
        WeiboViewLayoutFrame *layoutframe = [[WeiboViewLayoutFrame alloc] init];
        //isDetail 需要先赋值
        layoutframe.isDetail = YES;
        layoutframe.weiboModel = weiboModel;
        
        _weiboView.layoutFrame = layoutframe;
        _weiboView.frame = layoutframe.frame;
        _weiboView.top = _userView.bottom + 5;
        
        //2.用户视图
        _userView.weiboModel = weiboModel;
        
        //3.设置头视图
        _headView.height = _weiboView.bottom;
        
        self.tableHeaderView = _headView;
    }
}
#pragma mark - tableview 代理

- (NSInteger)numberOfSections {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.commentModel = self.commentDataArray[indexPath.row];
    
    return cell;
}
//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentModel *model = self.commentDataArray[indexPath.row];
    //计算单元格的高度
    CGFloat height = [CommentCell getCommentHeight:model];
    
    return height;
}
//组头视图，显示评论数
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //创建视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    
    //创建显示评论数的label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:16];
    
    NSNumber *total = [self.commentDic objectForKey:@"total_number"];
    int value = [total intValue];
    label.text = [NSString stringWithFormat:@"评论：%d",value];
    [view addSubview:label];

    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
@end
