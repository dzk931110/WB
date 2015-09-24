//
//  ThemeTableViewController.m
//  HWWeibo
//
//  Created by gj on 15/9/9.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "ThemeTableViewController.h"
#import "MoreTableViewCell.h"
#import "ThemeManager.h"

static NSString *moreCellId = @"moreCellId";

@interface ThemeTableViewController ()

@end

@implementation ThemeTableViewController{
    
    NSArray *themeNameArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return  self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"theme.plist" ofType:nil];
    
     NSDictionary *themeConfig = [NSDictionary dictionaryWithContentsOfFile:path];
    
    themeNameArray = [themeConfig allKeys];
    
    //注册
    [self.tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:moreCellId];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return themeNameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellId forIndexPath:indexPath];
    
    cell.themeTextLabel.text = themeNameArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *themeName = themeNameArray[indexPath.row];
    [[ThemeManager shareInstance] setThemeName:themeName];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
