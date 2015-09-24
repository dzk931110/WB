//
//  UserView.m
//  项目二
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "UserView.h"
#import "UIImageView+WebCache.h"

@implementation UserView

- (void)setWeiboModel:(WeiboModel *)weiboModel {
    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _userImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    _userImageView.layer.borderWidth = 1;
    _userImageView.layer.cornerRadius = _userImageView.width/2;
    _userImageView.layer.masksToBounds = YES;
    
    //1 用户头像
    NSString *url = self.weiboModel.userModel.avatar_large;
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    //2 昵称
    _nameLabel.text = self.weiboModel.userModel.screen_name;
    
    //3 发布来源
    _sourceLabel.text = [NSString stringWithFormat:@"%@",self.weiboModel.source];
}
@end
