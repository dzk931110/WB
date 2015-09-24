//
//  UserView.h
//  项目二
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"

@interface UserView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;


@property (nonatomic,strong)WeiboModel *weiboModel;
@end
