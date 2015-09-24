//
//  BaseViewController.h
//  项目二 - 微博
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AFHTTPRequestOperation.h"
@interface BaseViewController : UIViewController{
    //提示
    UIView *_tipView;
    
    MBProgressHUD *_hud;
    
    UIWindow *_tipWindow;//显示进度条
}

- (void)showLoading:(BOOL)show;
//设置背景图片
- (void)setBgImage;
//第三方
- (void)showHUD:(NSString *)title;
- (void)hideHUD;
- (void)completeHUD:(NSString *)title;

//状态栏提示
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
           operration:(AFHTTPRequestOperation *)operation;
@end
