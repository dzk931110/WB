//
//  CommentModel.m
//  项目二
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "CommentModel.h"
#import "Tools.h"


@implementation CommentModel

//- (id)initWithDataDic:(NSDictionary *)dataDic {
//    
//}
- (void)setAttributes:(NSDictionary *)dataDic {
    [super setAttributes:dataDic];
    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    UserModel *user = [[UserModel alloc] initWithDataDic:userDic];
    self.user = user;

    NSDictionary *status = [dataDic objectForKey:@"status"];
    WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:status];
    self.weibo = weibo;
    
    NSDictionary *commentDic = [dataDic objectForKey:@"reply_comment"];
    if (commentDic != nil) {
        CommentModel *sourceComment = [[CommentModel alloc] initWithDataDic:commentDic];
        self.sourceComment = sourceComment;
    }
    //处理评论中的表情
    self.text =[Tools parseTextImage:_text];
}

@end

