//
//  ThemeManager.m
//  项目二
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager

//单例
+ (ThemeManager *)shareInstance {
    static ThemeManager *instance = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {

        //01 读取本地持久化存储的主题名字
        _themeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
        //如果本地没有存储主题名字，则默认是cat
        if (_themeName.length == 0) {
            _themeName = @"Cat";
        }
        
        //02 读取主题名
        NSString *configPath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        // 将主题名存入字典中
        self.themeConfig = [NSDictionary dictionaryWithContentsOfFile:configPath];
        
        //03 读取颜色配置;;
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        self.colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    
    return self;
}

//设置主题名字，触发通知,主题切换
- (void)setThemeName:(NSString *)themeName {
    if (![_themeName isEqualToString:themeName]) {
        
        _themeName = [themeName copy];
        
        //01 把主题名字存储到plist中 NSUserDefaults
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //02 重新读取颜色配置文件
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        self.colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        //03 发通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotificationName object:nil];
    }
}
//颜色的后获取
- (UIColor *)getThemeColor:(NSString *)colorName {
    if (colorName.length == 0) {
        return nil;
    }
    NSDictionary *rgbDic = [_colorConfig objectForKey:colorName];
    CGFloat r = [rgbDic[@"R"] floatValue];
    CGFloat g = [rgbDic[@"G"] floatValue];
    CGFloat b = [rgbDic[@"B"] floatValue];
    
    CGFloat alpha = 1;
    
    if (rgbDic[@"alpha"] != nil) {
        alpha = [rgbDic[@"alpha"] floatValue];
    }
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    
    return color;
}
//图片的获取
- (UIImage *)getThemeImage:(NSString *)imageName {
    if (imageName.length == 0) {
        return nil;
    }
    //得到图片路径
    
    //01得到主题包路径
    NSString *themePath = [self themePath];
    
    //02拼接图片路径,,需要加／
    NSString *filePath = [themePath stringByAppendingPathComponent:imageName];
    
    //03读取图片
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    return image;
}
//主题包路径
- (NSString *)themePath {
    //01 获取主题包根路径
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    
    //02 当前主题包的路径
    NSString *themePath = [self.themeConfig objectForKey:self.themeName];
    
    //03 完整主题包的路径  需要加／
    NSString *path = [bundlePath stringByAppendingPathComponent:themePath];
    
    return path;
}
@end
