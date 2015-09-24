//
//  HomeViewController.h
//  项目二 - 微博
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "BaseViewController.h"
#import "SinaWeiboRequest.h"
#import "WeiboTableView.h"

@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate>{
    
    WeiboTableView *_weiboTable;
}

@end
