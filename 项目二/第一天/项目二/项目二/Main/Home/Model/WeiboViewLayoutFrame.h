//
//  WeiboViewLayoutFrame.h
//  项目二
//
//  Created by mac on 15/9/11.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"

@interface WeiboViewLayoutFrame : NSObject

@property (nonatomic, assign)CGRect textFrame;    //微博文字
@property (nonatomic, assign)CGRect srTextFrame;  //转发的微博文字
@property (nonatomic, assign)CGRect bgImageFrame; //微博背景
@property (nonatomic, assign)CGRect imageFrame;   //转发微博的图片

@property (nonatomic, assign)CGRect frame;        //整个weiboView的frame

@property (nonatomic, strong)WeiboModel *weiboModel; //

@property (nonatomic,assign) BOOL isDetail;//是否是详情页面布局

@end