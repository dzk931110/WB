//
//  WeiboCell.m
//  项目二
//
//  Created by mac on 15/9/11.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "WeiboCell.h"
#import "UIImageView+WebCache.h"

@implementation WeiboCell

- (void)awakeFromNib {
    // Initialization code
    //创建weiboview
    self.backgroundColor = [UIColor clearColor];
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    _weiboView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_weiboView];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//重写set方法
//- (void)setModel:(WeiboModel *)model {
//    if (_model != model) {
//        _model = model;
//        [self setNeedsLayout];
//        
//    }
//}

- (void)setLayoutFrame:(WeiboViewLayoutFrame *)layoutFrame {
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        [self setNeedsLayout];
    }
}
//重新布局
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //获取modal
    WeiboModel *_model = _layoutFrame.weiboModel;
    
    //头像
    NSString *urlStr = _model.userModel.profile_image_url;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    //昵称
    _nickNameLabel.text = _model.userModel.screen_name;
    
    //评论数
    _commentLabel.text = [NSString stringWithFormat:@"评论:%@",_model.commentsCount];//_model.commentsCount;
    //转发数
    _rePostLabel.text = [NSString stringWithFormat:@"转发:%@",_model.repostsCount];
    
    //微博来源
    _origLabel.text = _model.source;
    
    //微博内容设置
    _weiboView.layoutFrame = _layoutFrame;
#warning 整个weiboview的frame
    _weiboView.frame = _layoutFrame.frame;
    
}
@end
