//
//  CommentTableView.h
//  项目二
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "UserView.h"
#import "WeiboView.h"
#import "CommentCell.h"

@interface CommentTableView : UITableView <UITableViewDataSource,UITableViewDelegate>
{
    //用户视图
    UserView *_userView;
    //微博视图
    WeiboView *_weiboView;
    
    //头视图
    UIView *_headView;
    
}

@property (nonatomic,strong)WeiboModel *weiboModel;
@property (nonatomic,strong)NSArray *commentDataArray;
@property (nonatomic,strong)NSDictionary *commentDic;
@end
