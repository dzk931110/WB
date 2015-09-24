//
//  LeftViewController.m
//  项目二
//
//  Created by mac on 15/9/9.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "LeftViewController.h"
#import "ThemeLabel.h"


@interface LeftViewController ()

@end

@implementation LeftViewController
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    //读取数据
    [self loadData];
    
    //创建视图
    [self createView];
    
    [self setBgImage];
}
- (void)createView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(-5, 0, 165, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = nil;
    _tableView.backgroundView = nil;
    
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.view addSubview:_tableView];
    
}

//读取数据
- (void)loadData{
    _sectionTitles = @[@"界面切换效果",@"图片浏览模式"];
    
    _rowTitles = @[@[@"无",
                     @"偏移",
                     @"偏移&缩放",
                     @"旋转",
                     @"视差"],
                   @[@"小图",
                     @"大图"]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionTitles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_rowTitles[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"leftCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = _rowTitles[indexPath.section][indexPath.row];
    
    return cell;
}
//组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ThemeLabel *label = [[ThemeLabel alloc] initWithFrame:CGRectMake(0, 0, 160, 50)];
    label.colorName = @"More_Item_Text_color";
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18];
    label.text = [NSString stringWithFormat:@"    %@",_sectionTitles[section]];
    
    return label;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
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
