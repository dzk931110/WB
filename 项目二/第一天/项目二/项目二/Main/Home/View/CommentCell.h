//
//  CommentCell.h
//  项目二
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXLabel.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"


@interface CommentCell : UITableViewCell <WXLabelDelegate>
{
    __weak IBOutlet UIImageView *imgView;
    __weak IBOutlet UILabel *nameLabel;
    WXLabel *_commentTextLabel;
}

@property (nonatomic, retain)CommentModel *commentModel;
//计算评论单元格高度
+ (float)getCommentHeight:(CommentModel *)commentModel;


@end
