//
//  ProfileViewController.h
//  项目二 - 微博
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "BaseViewController.h"
#import "MyTableView.h"
#import "WeiboModel.h"


@interface ProfileViewController : BaseViewController

{
    MyTableView *_tableView;
}
@property (nonatomic, strong) WeiboModel *weiboModel;

//
@property (nonatomic, strong) NSMutableArray *data;

@end
