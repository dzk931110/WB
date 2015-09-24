//
//  MyView.h
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModel.h"

@interface MyView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *myName;
@property (weak, nonatomic) IBOutlet UILabel *myInfo;
@property (weak, nonatomic) IBOutlet UILabel *myIntr;
- (IBAction)focus:(id)sender;

@property (nonatomic, strong) MyModel *myModel;


@end
