//
//  MyView.h
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModel.h"
#import "UIView+ViewController.h"
#import "FriendViewController.h"
#import "FollowerViewController.h"

@interface MyView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *myName;
@property (weak, nonatomic) IBOutlet UILabel *myInfo;
@property (weak, nonatomic) IBOutlet UILabel *myIntr;
- (IBAction)button1:(UIButton *)sender;
- (IBAction)button2:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (nonatomic, strong) MyModel *myModel;


@end
