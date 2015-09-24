//
//  FaceScrollView.h
//  HWWeibo
//
//  Created by gj on 15/9/1.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceView.h"
@interface FaceScrollView : UIView<UIScrollViewDelegate>{
    
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    FaceView *_faceView;

}

- (void)setFaceViewDelegate:(id<FaceViewDelegate>)delegate;

@end
