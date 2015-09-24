//
//  AppDelegate.h
//  项目二
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate>
@property (strong, nonatomic) SinaWeibo *sinaweibo;
@property (strong, nonatomic) UIWindow *window;

@end

