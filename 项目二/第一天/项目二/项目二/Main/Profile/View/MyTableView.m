//
//  MyTableView.m
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "MyTableView.h"

@interface MyTableView (){
    
}

@end

@implementation MyTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self _createViews];
        //注册cell，从xib文件创建
        UINib *nib = [UINib nibWithNibName:@"MyCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:@"cell"];
    }
    
    return self;
}
- (void)_createViews{
    _myView = [[[NSBundle mainBundle] loadNibNamed:@"MyView" owner:nil options:nil] lastObject] ;
    _myView.backgroundColor = [UIColor clearColor];
    _myView.width = kScreenWidth;
    _myView.height = 180;
 
    self.tableHeaderView = _myView;
}
- (void)setMyModel:(MyModel *)myModel {
    if (_myModel != myModel) {
        _myModel = myModel;
        
        
        
    }
}
#pragma mark - tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:nil options:nil]lastObject];
    }
    
    cell.myModel = _dataArray[indexPath.row];
    _myView.myModel = cell.myModel;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _myModel = _dataArray[indexPath.row];
    
    return [MyCell getCellHeight:_myModel];
}
//组头视图,返回中的微博数
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    
    NSNumber *total = [self.dic objectForKey:@"total_number"];
    int value = [total intValue];
    label.text = [NSString stringWithFormat:@"共%d条微博",value];
    
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

@end
