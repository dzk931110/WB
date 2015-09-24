//
//  BaseViewController.m
//  项目二 - 微博
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "BaseViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "ThemeManager.h"
#import "ThemeButton.h"
#import "UIProgressView+AFNetworking.h"


@interface BaseViewController (){
 
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
//    [self setNavItem];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        //注册通知监听者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    
    return self;
}

- (void)themeDidChange:(NSNotification *)notification{
//    [self setNavItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//设置导航栏按钮
- (void)setNavItem{
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setAction)];
//    
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
//    [self.navigationItem.rightBarButtonItem = [UIBarButtonItem alloc] initWithCustomView:<#(UIView *)#>];
    //获得主题管家
    ThemeManager *themeManager = [ThemeManager shareInstance];
    
//    _leftLabel = [[ThemeLabel alloc] init];
//    _leftLabel.font = [UIFont systemFontOfSize:10];
//    _leftLabel.text = @"设置";
//    UIColor *color = [themeManager getThemeColor:@"Mask_Title_color"];
//    _leftLabel.textColor = color;
    
    
    //左边按钮
    ThemeButton *button = [ThemeButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 40);

    //button按钮的图片
    button.normalImageName = @"group_btn_all_on_title.png";
    
    UIColor *color = [themeManager getThemeColor:@"More_Item_Text_color"];
    [button setTitleColor:color forState:UIControlStateNormal];
    UIImage *image = [themeManager getThemeImage:@"button_title.png"];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"设置" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    //右边按钮
    
    ThemeButton *button1 = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    
    //button按钮的图片
    button1.normalImageName = @"button_icon_plus.png";
    
    UIImage *image1 = [themeManager getThemeImage:@"button_title.png"]; // button_m.png 图有缺失
    [button1 setBackgroundImage:image1 forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"编辑"forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
}

- (void)setAction{
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (void)editAction{
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

//自己创建
- (void)showLoading:(BOOL)show{
    
    if (_tipView == nil) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight/2-30, kScreenWidth, 20)];
        _tipView.backgroundColor = [UIColor clearColor];
    
    //01 创建UIActivityIndicatorView
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.tag = 100;
    [_tipView addSubview:activityView];
    
    
    //02 创建label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"正在加载";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    [_tipView addSubview:label];
    
    label.left = (kScreenWidth-label.width)/2;
    activityView.right = label.left-5;
    }
    
    if (show) {
        UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[_tipView viewWithTag:100];
        [activityView startAnimating];
        [self.view addSubview:_tipView];
    }else{
        if (_tipView.superview) {
            UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[_tipView viewWithTag:100];
            [activityView stopAnimating];
            [_tipView removeFromSuperview];
        }
    }
    
}
//第三方
- (void)showHUD:(NSString *)title {
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [_hud show:YES];
    _hud.labelText = title;
    _hud.dimBackground = YES;
//    _hud.detailsLabelText = @"测试";
}
- (void)hideHUD {
    [_hud hide:YES];
}
- (void)completeHUD:(NSString *)title{
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.labelText = title;
    
    //持续1.5s隐藏
    [_hud hide:YES afterDelay:1.5];
}
//修改左边背景
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setBgImage{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_loadImage) name:kThemeDidChangeNotificationName object:nil];
    [self _loadImage];
}
- (void)_loadImage{
    ThemeManager *manager = [ThemeManager shareInstance];
    UIImage *image = [manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}
#pragma mark - 状态栏提示
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
           operration:(AFHTTPRequestOperation *)operation;{
    
    if (_tipWindow == nil) {
        //01 创建window，放在状态栏上面
        _tipWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        //优先级
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        _tipWindow.backgroundColor = [UIColor blackColor];
        
        //02 label显示文字
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:_tipWindow.bounds];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = [UIFont systemFontOfSize:13.0];
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.tag = 100;
        [_tipWindow addSubview:tipLabel];
        
        //03 创建进度条
        UIProgressView *progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progress.frame = CGRectMake(0, 17, kScreenWidth, 5);
        progress.tag = 100;
        progress.progress = 0.0;
        [_tipWindow addSubview:progress];
        
    }
    
    UILabel *tipLabel = (UILabel *)[_tipWindow viewWithTag:100];
    tipLabel.text = title;
    
    
    UIProgressView *progressView = (UIProgressView *)[_tipView viewWithTag:101];
    if (show) {
        _tipWindow.hidden = NO;
        if (operation != nil) {
            progressView.hidden = NO;
            [progressView setProgressWithUploadProgressOfOperation:operation animated:YES];
        }else {
            progressView.hidden = YES;
        }
    }else {
        //延迟调用 
        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:1];
    }
}
- (void)removeTipWindow {
    _tipWindow.hidden = YES;
    _tipWindow = nil;
}
@end
