//
//  LeftViewController.h
//  项目二
//
//  Created by mac on 15/9/9.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LeftViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_sectionTitles;
    NSArray *_rowTitles;
    
}

@end
