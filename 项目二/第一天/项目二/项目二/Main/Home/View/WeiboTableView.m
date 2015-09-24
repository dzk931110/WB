//
//  WeiboTableView.m
//  项目二
//
//  Created by mac on 15/9/11.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "UIView+ViewController.h"
#import "DetailViewController.h"

@implementation WeiboTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initTable];
    }
    
    return self;
}

- (void)awakeFromNib {
    [self _initTable];
}
- (void)_initTable {
    self.delegate = self;
    self.dataSource = self;
    
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:@"WeiboCellId"];
    
}
#pragma mark - tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _layoutFrameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeiboCellId"];
    
    WeiboViewLayoutFrame *layoutFrame = _layoutFrameArray[indexPath.row];
    
    //定制
    cell.layoutFrame = layoutFrame;

    return cell;
}

//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeiboViewLayoutFrame *layoutFrame = _layoutFrameArray[indexPath.row];
    
    CGFloat height = layoutFrame.frame.size.height;

    return height + 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //通过view找到viewcontroller
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    //传递weibomodel数据
    WeiboViewLayoutFrame *layoutFrame = _layoutFrameArray[indexPath.row];
    vc.weiboModel = layoutFrame.weiboModel;
    
    
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}
@end
