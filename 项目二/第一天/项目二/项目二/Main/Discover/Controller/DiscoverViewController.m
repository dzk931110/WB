//
//  DiscoverViewController.m
//  项目二 - 微博
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "DiscoverViewController.h"
#import "NearByViewController.h"
#import "NearPeopleViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//附近的微博
- (IBAction)NearByWeibo:(UIButton *)sender {
    NearByViewController *nearBy = [[NearByViewController alloc] init];
    [self.navigationController pushViewController:nearBy animated:YES];
}
//附近的人
- (IBAction)NearByPeople:(UIButton *)sender {
    NearPeopleViewController *nearPeople = [[NearPeopleViewController alloc] init];
    [self.navigationController pushViewController:nearPeople animated:YES];
}
@end
