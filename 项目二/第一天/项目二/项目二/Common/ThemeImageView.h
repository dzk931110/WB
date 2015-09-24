//
//  ThemeImageView.h
//  项目二
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

@property (nonatomic, copy)NSString *imgName;

//进行拉伸 接口
@property (nonatomic, assign)CGFloat leftCapWidth;
@property (nonatomic, assign)CGFloat topCapWidth;
@end
