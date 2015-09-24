//
//  BaseNavController.m
//  项目二 - 微博
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "BaseNavController.h"
#import "ThemeManager.h"
@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //第一次运行时也有图片
    [self loadImage];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//xib创建出来，调用该init方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //注册通知监听者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    
    return self;
}
- (void)themeDidChange:(NSNotification *)notification{
    [self loadImage];
}

- (void)loadImage{
    //01 获取主题管家
    ThemeManager *manager = [ThemeManager shareInstance];
    
    //02 修改导航栏背景
    UIImage *image = [manager getThemeImage:@"mask_titlebar64.png"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //03 修改主题文字颜色
    UIColor *color = [manager getThemeColor:@"Mask_Title_color"];
    NSDictionary *attrDic = @{NSForegroundColorAttributeName:color};
    self.navigationBar.titleTextAttributes = attrDic;
    
    //04 修改视图背景
    UIImage *bgimage = [manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgimage];
    
    //导航栏按钮
//    self.navigationBar.tintColor = color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
