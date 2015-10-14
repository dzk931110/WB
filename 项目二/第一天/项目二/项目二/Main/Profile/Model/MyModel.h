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

@property (nonatomic , copy) NSString *text;//微博信息内容
@property (nonatomic , copy) NSString *created_at;//创建时间
@property (nonatomic , copy) NSString *source;//来源

@property (nonatomic , retain) NSNumber *reposts_count;//转发数
@property (nonatomic , retain) NSNumber *comments_count;//评论数
@property (nonatomic , copy) NSString  *weiboIdStr;     //字符串类型id
@property (nonatomic , copy) NSString *thumbnail_pic;
@property (nonatomic , retain) NSNumber *total_number;


@property (nonatomic, strong) UserModel *userModel;
@property (nonatomic, strong) WeiboModel *reWeiboModel; //被转发的微博

@end
