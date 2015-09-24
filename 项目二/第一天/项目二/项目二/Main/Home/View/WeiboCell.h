//
//  WeiboCell.h
//  项目二
//
//  Created by mac on 15/9/11.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboView.h"
#import "WeiboViewLayoutFrame.h"

@interface WeiboCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rePostLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *origLabel;

//@property (nonatomic, strong)WeiboModel *model;
@property (nonatomic, strong)WeiboViewLayoutFrame *layoutFrame; //布局对象

@property (nonatomic, strong)WeiboView *weiboView;
@end
