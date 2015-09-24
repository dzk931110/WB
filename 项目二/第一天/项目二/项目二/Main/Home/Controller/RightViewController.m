//
//  RightViewController.m
//  项目二
//
//  Created by mac on 15/9/9.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "RightViewController.h"
#import "ThemeButton.h"
#import "SendViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "BaseNavController.h"
#import "NearByController.h"


@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBgImage];
    //图片的数组
    NSArray *imageNames = @[@"newbar_icon_1.png",
                            @"newbar_icon_2.png",
                            @"newbar_icon_3.png",
                            @"newbar_icon_4.png",
                            @"newbar_icon_5.png"];
    
    //创建主题按钮
    for (int index = 0; index < imageNames.count; index ++) {
        //创建
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(20, 64 + index * (40 + 10), 40, 40)];
        button.normalImageName = imageNames[index];
        
        button.tag = index;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
}

- (void)buttonAction:(UIButton *)button {
    if (button.tag == 0) {
        //发送微博
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
           
            //弹出发送微博控制器
            SendViewController *sendVc = [[SendViewController alloc]init];
            sendVc.title = @"发送微博";
            
            //创建导航控制器
            BaseNavController *baseNav = [[BaseNavController alloc] initWithRootViewController:sendVc];
            //模态视图弹出
            [self.mm_drawerController presentViewController:baseNav animated:YES completion:nil];
        }];
    }else if (button.tag == 1){
        
    }else if (button.tag == 2){
        
    }else if (button.tag == 3){
        
    }else if (button.tag == 4){    // 定位显示附近商家
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
            
            NearByController *nearBy = [[NearByController alloc] init];
            nearBy.title = @"附近商圈";
            //创建导航控制器
            BaseNavController *baseNav = [[BaseNavController alloc] initWithRootViewController:nearBy];
            
            [self.mm_drawerController presentViewController:baseNav animated:YES completion:nil];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
