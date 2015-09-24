//
//  WeiboTableView.h
//  项目二
//
//  Created by mac on 15/9/11.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboViewLayoutFrame.h"

@interface WeiboTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic, strong) NSArray *dataArray;


@property (nonatomic, strong) NSArray *layoutFrameArray;
@end
