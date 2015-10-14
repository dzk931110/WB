//
//  MyCell.h
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXLabel.h"
#import "MyModel.h"
#import "ZoomImageView.h"
#import "Utils.h"

@interface MyCell : UITableViewCell <WXLabelDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellName;
@property (weak, nonatomic) IBOutlet UILabel *cellComment;
@property (weak, nonatomic) IBOutlet UILabel *cellSend;
@property (weak, nonatomic) IBOutlet UILabel *cellDate;
@property (weak, nonatomic) IBOutlet UILabel *cellSource;

@property (nonatomic, strong) WXLabel *wxLabel;
@property (nonatomic, strong) ZoomImageView *myImageView;
@property (nonatomic, strong) MyModel *myModel;

//计算单元格高度
+ (CGFloat)getCellHeight :(MyModel *)myModel;

@end
