//
//  ThemeLabel.m
//  项目二
//
//  Created by mac on 15/9/9.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"

@implementation ThemeLabel


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name: kThemeDidChangeNotificationName object:nil];
    }
    
    return self;
}
//从xib文件创建出来
- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name: kThemeDidChangeNotificationName object:nil];
    
}
- (void)setColorName:(NSString *)colorName {
    if (![_colorName isEqualToString:colorName]) {
        _colorName = [colorName copy];
        [self loadColor];
    }
}
//收到通知调用的方法
- (void)themeDidChange:(NSNotification *)notification{
    
    [self loadColor];
}
- (void)loadColor {
    ThemeManager *manager = [ThemeManager shareInstance];
    self.textColor = [manager getThemeColor:_colorName];
}
@end
