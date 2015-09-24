//
//  WeiboView.h
//  项目二
//
//  Created by mac on 15/9/11.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "WeiboViewLayoutFrame.h"
#import "WXLabel.h"
#import "ThemeManager.h"
#import "ZoomImageView.h"


@interface WeiboView : UIView <WXLabelDelegate>

@property (nonatomic, strong)WXLabel *textLabel; // 微博文字
@property (nonatomic, strong)WXLabel *sourceLabel; //原微博名字

@property (nonatomic, strong)ZoomImageView *imageView;//微博图片
@property (nonatomic, strong)ThemeImageView *bgImageView;//原微博背景图片

@property (nonatomic, strong) WeiboViewLayoutFrame * layoutFrame; //布局对象


@end
