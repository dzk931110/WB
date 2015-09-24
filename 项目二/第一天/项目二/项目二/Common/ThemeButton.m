//
//  ThemeButton.m
//  项目二
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"


@implementation ThemeButton

//一定要移除通知监听
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //注册通知监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    
    return self;
}

- (void)setNormalImageName:(NSString *)normalImageName {
    if (![_normalImageName isEqualToString:normalImageName]) {
        _normalImageName = [normalImageName copy];
        [self loadImage];
    }
}

- (void)setHighLightImageName:(NSString *)highLightImageName {
    if (![_highLightImageName isEqualToString:highLightImageName]) {
        _highLightImageName = [highLightImageName copy];
        [self loadImage];
    }
}
//收到通知重新修改图片
- (void)themeDidChange:(NSNotification *)notification{
    //重新修改图片
    [self loadImage];
}
- (void)loadImage{
    
    //得到主题管家对象
    ThemeManager *manager = [ThemeManager shareInstance];
    
    //通过管家得到图片
    UIImage *normalImage = [manager getThemeImage:self.normalImageName];
    UIImage *highLightImage = [manager getThemeImage:self.highLightImageName];
    
    
    UIColor *color = [manager getThemeColor:@"Mask_Title_color"];
    [self setTitleColor:color forState:UIControlStateNormal];
    
    //给button设置图片
    if (normalImage != nil) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    if (highLightImage != nil) {
        [self setImage:highLightImage forState:UIControlStateHighlighted];
    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name: kThemeDidChangeNotificationName object:nil];
    
}
@end
