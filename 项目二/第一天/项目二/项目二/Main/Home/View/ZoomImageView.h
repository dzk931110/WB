//
//  ZoomImageView.h
//  项目二
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZoomImageView;

//设置代理协议
@protocol ZoomImageViewDelegate <NSObject>

@optional
//图片将要放大
- (void)imageWillZoomIn:(ZoomImageView *)imageView;
//图片将要缩小
- (void)imageWillZoomOut:(ZoomImageView *)imageView;
//已经放大
//已经缩小

@end


@interface ZoomImageView : UIImageView <NSURLConnectionDataDelegate,UIAlertViewDelegate>
{
    UIScrollView *_scrollview;
    UIImageView *_fullImageView;
}
@property (nonatomic, weak) id<ZoomImageViewDelegate> delegate;
//大图
@property (nonatomic, strong)NSString *fullImageUrlString;
//gif
@property (nonatomic, assign) BOOL isGIF;

@property (nonatomic, strong) UIImageView *iconView;
@end
