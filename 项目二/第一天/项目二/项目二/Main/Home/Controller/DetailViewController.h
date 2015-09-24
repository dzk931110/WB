//
//  DetailViewController.h
//  项目二
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboModel.h"
#import "CommentTableView.h"
#import "SinaWeibo.h"

@interface DetailViewController : BaseViewController<SinaWeiboRequestDelegate>
{
    CommentTableView *_commentTableView;
}
@property (nonatomic ,strong) WeiboModel *weiboModel;

//评论列表数据
@property(nonatomic,strong)NSMutableArray *data;

@end
