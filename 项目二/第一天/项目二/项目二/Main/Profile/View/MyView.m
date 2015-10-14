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
    
    //关注
    _label1.text = [NSString stringWithFormat:@"%@关注",self.myModel.userModel.friends_count];
    _label1.numberOfLines = 0;
    _label1.textColor = [UIColor blueColor];
    _label1.font = [UIFont systemFontOfSize:14];
    
    _label2.text = [NSString stringWithFormat:@"%@粉丝",self.myModel.userModel.followers_count];
    _label2.numberOfLines = 0;
    _label2.textColor = [UIColor blueColor];
    _label2.font = [UIFont systemFontOfSize:14];
}

//关注friends
- (IBAction)button1:(UIButton *)sender {
    NSLog(@"111");
//    FriendViewController *friendVC = [[FriendViewController alloc] init];
//    
//    [self.viewController.navigationController pushViewController:friendVC animated:YES];
    
}
//粉丝followers
- (IBAction)button2:(UIButton *)sender {
    
    
}
@end
