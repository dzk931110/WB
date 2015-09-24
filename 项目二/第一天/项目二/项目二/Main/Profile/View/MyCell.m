//
//  MyCell.m
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "MyCell.h"
#import "UIImageView+WebCache.h"
#import "ThemeManager.h"
#import "Tools.h"
@implementation MyCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _wxLabel = [[WXLabel alloc] init];
        _wxLabel.font = [UIFont systemFontOfSize:13];
        _wxLabel.linespace = 5;
        _wxLabel.wxLabelDelegate = self;
        [self.contentView addSubview:_wxLabel];
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}
- (void)setMyWeibo:(MyModel *)myWeibo {
    if (_myWeibo != myWeibo) {
        _myWeibo = myWeibo;
        
        [self setNeedsLayout];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //头像
    NSString *urlString = _myWeibo.userModel.profile_image_url;
    [_cellImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    
    //昵称
    _cellName.text = _myWeibo.userModel.screen_name;
    
    //内容
    CGFloat height = [WXLabel getTextHeight:13 width:240 text:_myWeibo.text linespace:5];
    _wxLabel.frame = CGRectMake(_cellImageView.right+5, _cellName.bottom+5, kScreenWidth-70, height);
    
    _wxLabel.text = _myWeibo.text;
    
    //转发数
    _cellSend.text = [NSString stringWithFormat:@"%@",_myWeibo.resend];
    
    //评论数
    _cellComment.text = [NSString stringWithFormat:@"%@",_myWeibo.comment];
    
    //日期
    _cellDate.text = [Tools weiboDateString:[NSString stringWithFormat:@"%@",_myWeibo.date]];
    NSLog(@"%@",_myWeibo.date);
    
    //来源
    _cellSource.text = _myWeibo.source;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//返回一个正则表达式，通过此正则表达式查找出需要添加超链接的文本
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel {
    //需要添加连接的字符串的正则表达式：@用户、http://... 、 #话题#
    NSString *regex1 = @"@\\w+"; //@"@[_$]";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#^#+#";  //\w 匹配字母或数字或下划线或汉字
    
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    
    return regex;
}

// 设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel {
    UIColor *linkColor = [[ThemeManager shareInstance] getThemeColor:@"Link_color"];
    return linkColor;
}
//设置当前文本手指划过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel {
    return [UIColor darkGrayColor];
}


+ (CGFloat)getCellHeight:(MyModel *)myWeibo {
    CGFloat height = [WXLabel getTextHeight:13 width:kScreenWidth - 70 text:myWeibo.text linespace:5];
    
    return height+40;
}

@end
