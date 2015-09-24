//
//  WeiboAnnotationView.m
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "WeiboAnnotation.h"
#import "UIImageView+WebCache.h"

@implementation WeiboAnnotationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.bounds = CGRectMake(0, 0, 100, 40);
        [self _createViews];
        
    }
    
    return self;
}
//创建label
- (void)_createViews {
    //创建头像视图
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self addSubview:_headImageView];
    
    //
    _label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 60, 40)];
    _label.backgroundColor = [UIColor lightGrayColor];
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont systemFontOfSize:13];
    _label.numberOfLines = 3;
    [self addSubview:_label];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    WeiboAnnotation *annotation = self.annotation;
    WeiboModel *model = annotation.weiboModel;
    _label.text = model.text;
    NSString *urlString = model.userModel.profile_image_url;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"icon"]];

}
@end
