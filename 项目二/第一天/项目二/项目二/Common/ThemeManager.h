//
//  ThemeManager.h
//  项目二
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kThemeDidChangeNotificationName @"kThemeDidChangeNotificationName"
#define kThemeName @"kThemeName"

@interface ThemeManager : NSObject

@property (nonatomic, copy)NSString *themeName;         //主题名字
@property (nonatomic, strong)NSDictionary *themeConfig; //存储theme.plist的内容
@property (nonatomic, strong)NSDictionary *colorConfig; //每个主题下config.plist的内容（颜色）

- (UIImage *)getThemeImage:(NSString *)imageName;//根据图片名字来获得对应主题包的图片

+ (ThemeManager *)shareInstance; //单例类方法，获得唯一对象

- (UIColor *)getThemeColor:(NSString *)colorName;


@end
