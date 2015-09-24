//
//  MyView.m
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "MyView.h"
#import "UIImageView+WebCache.h"
@implementation MyView

- (IBAction)focus:(id)sender {
    
}
- (void)setMyModel:(MyModel *)myModel {
    if (_myModel != myModel) {
        _myModel = myModel;
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //01 用户头像
    [_myImageView sd_setImageWithURL:[NSURL URLWithString:self.myModel.userModel.avatar_large]];

    //02 昵称
    _myName.text = self.myModel.userModel.screen_name;
    
    //
    _myInfo.text = self.myModel.userModel.location;
    
    _myIntr.text = self.myModel.userModel.myDescription;
    
}

@end
