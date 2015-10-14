//
//  MyTableView.h
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyView.h"
#import "MyCell.h"
#import "MyModel.h"

@interface MyTableView : UITableView <UITableViewDelegate,UITableViewDataSource>
{
    //头视图
    UIView *_headView;
    //用户视图
    MyView *_myView;
}

@property (nonatomic, strong) MyModel *myModel;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSDictionary *dic;

@end
