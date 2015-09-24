//
//  UserModel.m
//  项目二
//
//  Created by mac on 15/9/11.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (NSDictionary*)attributeMapDictionary{
    
    //   @"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{
                             @"idstr":@"idstr",
                             @"screen_name":@"screen_name",
                             @"name":@"name",
                             @"location":@"location",
                             @"myDescription":@"description",
                             @"url":@"url",
                             @"profile_image_url":@"profile_image_url",
                             @"avatar_large":@"avatar_large",
                             @"gender":@"gender",
                             @"followers_count":@"followers_count",
                             @"friends_count":@"friends_count",
                             @"statuses_count":@"statuses_count",
                             @"favourites_count":@"favourites_count",
                             @"verified":@"verified"
                             };
    return mapAtt;
}
@end
