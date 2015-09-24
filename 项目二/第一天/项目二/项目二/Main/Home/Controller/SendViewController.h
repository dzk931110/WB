//
//  SendViewController.h
//  项目二
//
//  Created by mac on 15/9/17.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "BaseViewController.h"
#import "ZoomImageView.h"
#import <CoreLocation/CoreLocation.h>
#import "FaceScrollView.h"

@interface SendViewController : BaseViewController
{
    //1 文本编辑栏
    UITextView *_textView;
    
    //2 工具栏
    UIView *_toolBarView;
    
    //3 显示缩略图
    ZoomImageView *_zoomImageView;
    
    //4 位置管理
    CLLocationManager *_locationManager;
    UILabel *_locationLabel;
    
    //5 表情面板
    FaceScrollView *_faceViewPanel;
    
}
@end
