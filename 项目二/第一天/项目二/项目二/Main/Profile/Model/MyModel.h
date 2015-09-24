//
//  MyModel.h
//  项目二
//
//  Created by mac on 15/9/23.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
#import "WeiboModel.h"

@interface MyModel : BaseModel

@property (nonatomic, copy) NSString *text;  // 内容
@property (nonatomic, copy) NSString *date;  //日期
@property (nonatomic, copy) NSString *source;// 来源
@property (nonatomic, assign) NSNumber *resend;// 转发
@property (nonatomic, assign) NSNumber *comment; //评论
@property (nonatomic, copy) NSString *image;  //头像
@property (nonatomic, copy) NSString *name;   //昵称

@property (nonatomic, strong) UserModel *userModel;
@property (nonatomic, strong) WeiboModel *reWeiboModel;

@end
