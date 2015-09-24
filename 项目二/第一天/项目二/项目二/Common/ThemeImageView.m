//
//  ThemeImageView.m
//  项目二
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"

@implementation ThemeImageView


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name: kThemeDidChangeNotificationName object:nil];
    }
    
    return self;
}

- (void)setImgName:(NSString *)imgName {
    if (![_imgName isEqualToString:imgName]) {
        _imgName = imgName;
        [self loadImage];
    }
}
- (void)themeDidChange:(NSNotification *)notification{
    
    [self loadImage];
}
- (void)loadImage {
    ThemeManager *manager = [ThemeManager shareInstance];

    UIImage *image = [manager getThemeImage:self.imgName];
    //拉伸
    UIImage *tempImage = [image stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapWidth];
    
    
    
    
    if (image != nil) {
        self.image = tempImage;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name: kThemeDidChangeNotificationName object:nil];
    
}
@end
