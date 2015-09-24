//
//  WeiboAnnotationView.h
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface WeiboAnnotationView : MKAnnotationView
{
    UILabel *_label; // 微博内容
    
    UIImageView *_headImageView; // 头像视图
}
@end
