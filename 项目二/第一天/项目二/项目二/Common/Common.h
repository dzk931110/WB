//
//  Common.h
//  项目二 - 微博
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#ifndef _________Common_h
#define _________Common_h

//新浪微博
#define kAppKey             @"1866520408"
#define kAppSecret          @"33cfd1d72f909a3fd0f5d10aeab4d252"
#define kAppRedirectURI     @"https://api.wei.com/oauth2/default.html"

#import "UIImageView+WebCache.h"

//版本信息
#define kVersion [[UIDevice currentDevice].systemVersion doubleValue]
//屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//若是以后接口改变，方便修改
#define unread_count  @"remind/unread_count.json" //未读消息
#define home_timeline @"statuses/home_timeline.json"//微博列表
#define user_timeline @"statuses/user_timeline.json"//用户
#define comments      @"comments/show.json"  //评论列变
#define send_update @"statuses/update.json"  //发微博(不带图片)
#define send_upload @"statuses/upload.json"  //发微博(带图片)
#define geo_to_address @"location/geo/geo_to_address.json"  //查询坐标对应的位置
#define nearby_pois @"place/nearby/pois.json" // 附近商圈
#define nearby_timeline  @"place/nearby_timeline.json" //附近动态

//微博字体
#define FontSize_Weibo(isDetail) isDetail?16:15
#define FontSize_ReWeibo(isDetail) isDetail?15:14



#endif
