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


@implementation MyCell

- (void)awakeFromNib {

    [self layoutSubviews];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _wxLabel = [[WXLabel alloc] init];
        _wxLabel.font = [UIFont systemFontOfSize:13];
        _wxLabel.linespace = 5;
        _wxLabel.wxLabelDelegate = self;
        [self.contentView addSubview:_wxLabel];
        
        _myImageView = [[ZoomImageView alloc] init];
        [self.contentView addSubview:_myImageView];
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setMyModel:(MyModel *)myModel {
    if (_myModel != myModel) {
        _myModel = myModel;
        
        [self setNeedsLayout];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //头像
    NSString *urlString = _myModel.userModel.profile_image_url;
    [_cellImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    
    //昵称
    _cellName.text = _myModel.userModel.screen_name;
    
    //内容
    CGFloat height = [WXLabel getTextHeight:13
                                      width:240
                                       text:_myModel.text
                                  linespace:5];
    
    _wxLabel.frame = CGRectMake(_cellImageView.right+10, _cellName.bottom+5, 240, height);
    
    _wxLabel.text = _myModel.text;
    
//    if (_myModel.thumbnail_pic != nil) {
//        [_myImageView sd_setImageWithURL:[NSURL URLWithString:_myModel.thumbnail_pic]];
//        _myImageView.frame = CGRectMake(_cellImageView.right+65, _cellName.bottom+10, 60, 60);
//    }
    
    //转发数
    _cellSend.text = [NSString stringWithFormat:@"%@",_myModel.reposts_count];
    
    //评论数
    _cellComment.text = [NSString stringWithFormat:@"%@",_myModel.comments_count];
    
    //日期
    _cellDate.text = [Utils weiboDateString:_myModel.created_at];
    NSLog(@"mymodel.created_at =%@",_myModel.created_at);
//    NSLog(@"celldate = %@",_cellDate.text);
    
    
    //来源
    _cellSource.text = _myModel.source;
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


+ (CGFloat)getCellHeight:(MyModel *)myModel {
    CGFloat height = [WXLabel getTextHeight:13
                                      width:kScreenWidth - 70
                                       text:myModel.text
                                  linespace:5];
    
//    if (myModel.reWeiboModel.text != nil) { // 有转发微博
//        CGFloat reHeight = [WXLabel getTextHeight:13 width:240 text:myModel.reWeiboModel.text linespace:5];
//        
//        if (myModel.reWeiboModel.thumbnailImage != nil) { // 有图
//            
//            return height+reHeight+100;
//        }else{     
//            return height+reHeight+60;
//        }
//    }else {  // 没有转发微博
    
        if (myModel.thumbnail_pic != nil)
        {
            return height + 40 + 60;
        }
        else
        {
            return height+60;
        }
//    }
}

@end
