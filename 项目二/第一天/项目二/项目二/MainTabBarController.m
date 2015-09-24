//
//  MainTabBarController.m
//  项目二 - 微博
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavController.h"
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "AppDelegate.h"
#import "SinaWeiboRequest.h"
#import "ThemeLabel.h"

@interface MainTabBarController ()<SinaWeiboRequestDelegate>
{
    ThemeImageView *_selectedImageView;
    
    ThemeLabel *_badgeLabel;
    ThemeImageView *_badgeImageView;
    
}
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建子视图控制器
    [self _createSubControllers];
    //设置tabbar
    [self _createTabBar];
    
    //创建定时器 请求unread_count借口 获取未读微博，🆕粉丝数量，新评论
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)_createTabBar {
    //01 移除原有的tabbarbutton
    //UITabBarButton
    for (UIView *view in self.tabBar.subviews) {
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }

    //02创建imageView作为子视图添加到tabbar
    ThemeImageView *bgImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, 49)];
//    bgImageView.image = [UIImage imageNamed:@"Skins/cat/mask_navbar.png"];
    bgImageView.imgName = @"mask_navbar.png";
    
    [self.tabBar addSubview:bgImageView];
    
    //03选中视图
    _selectedImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 4, 49)];
//    _selectedImageView.image = [UIImage imageNamed:@"Skins/cat/home_bottom_tab_arrow.png"];
    _selectedImageView.imgName = @"home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectedImageView];
    
    //04 循环创建tabbar上的按钮
//    NSArray *imageNames = @[@"Skins/cat/home_tab_icon_1.png",
//                            @"Skins/cat/home_tab_icon_2.png",
//                            @"Skins/cat/home_tab_icon_3.png",
//                            @"Skins/cat/home_tab_icon_4.png",
//                            @"Skins/cat/home_tab_icon_5.png",
//                            ];
    NSArray *imageNames = @[@"home_tab_icon_1.png",

                            @"home_tab_icon_3.png",
                            @"home_tab_icon_4.png",
                            @"home_tab_icon_5.png",
                            ];
    //按钮宽度
    CGFloat buttonWidth = kScreenWidth / imageNames.count;
    for (int i = 0; i<imageNames.count; i++ ) {
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, 49)];

        button.normalImageName = imageNames[i];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.tabBar addSubview:button];
    }
}

- (void)buttonAction:(UIButton *)button {
    [UIView animateWithDuration:.1 animations:^{
        //移动选中视图
        _selectedImageView.center = button.center;
    }];
    //切换视图控制器
    self.selectedIndex = button.tag;
}

- (void)_createSubControllers {
    
    NSArray *names = @[@"Home",@"Profile",@"Discover",@"More"];
    NSMutableArray *navArray = [[NSMutableArray alloc] initWithCapacity:names.count];
    
    for (int i = 0; i < names.count; i ++) {
        NSString *name = names[i];
        //创建storyboard对象
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
        //创建导航控制器对象
        BaseNavController *navVc = [storyBoard instantiateInitialViewController];
        
        [navArray addObject:navVc];
    }

    self.viewControllers = navArray;
}
#pragma mark - 未读消息数的获取
- (void)timerAction{
    //请求数据
    AppDelegate *appDelagate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelagate.sinaweibo;
    [sinaWeibo requestWithURL:unread_count params:nil httpMethod:@"GET" delegate:self];
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    //numer_notify_9.png
    //Timeline_Notice_color
    NSNumber *status = [result objectForKey:@"status"];
    NSInteger count = [status integerValue];
    
    CGFloat tabBarButtonWidth = kScreenWidth/4;
    if (_badgeImageView == nil) {
        _badgeImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(tabBarButtonWidth-32, 0, 32, 32)];
        _badgeImageView.imgName = @"number_notify_9.png";
        [self.tabBar addSubview:_badgeImageView];
        
        _badgeLabel = [[ThemeLabel alloc] initWithFrame:_badgeImageView.bounds];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.backgroundColor = [UIColor clearColor];
        _badgeLabel.font = [UIFont systemFontOfSize:13];
        _badgeLabel.colorName = @"Timeline_Notice_color";
        [_badgeImageView addSubview:_badgeLabel];
    }
    
    if (count > 0) {
        _badgeImageView.hidden = NO;
        
        if (count > 99) {
            _badgeLabel.text = @"99+";
        }
        _badgeLabel.text = [NSString stringWithFormat:@"%li",count];
    }else {
        _badgeImageView.hidden = YES;
    }
}

@end
