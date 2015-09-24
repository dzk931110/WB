//
//  WeiboView.m
//  项目二
//
//  Created by mac on 15/9/11.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "WeiboView.h"
#import "UIImageView+WebCache.h"

@implementation WeiboView 

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//xib文件创建
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    
//}

//alloc创建
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self _createSubViews];
    }
    
    return self;
}
- (void)setLayoutFrame:(WeiboViewLayoutFrame *)layoutFrame {
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        [self setNeedsLayout];
    }
}

- (void)_createSubViews {
    
    //微博内容
    _textLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
//    _textLabel.font = [UIFont systemFontOfSize:16];
    _textLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    _textLabel.linespace = 5;
    _textLabel.wxLabelDelegate = self;
    [self addSubview:_textLabel];
    
    //原微博内容
    _sourceLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
//    _sourceLabel.font = [UIFont systemFontOfSize:14];
    _sourceLabel.linespace = 5;
    _sourceLabel.wxLabelDelegate = self;
    _sourceLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    [self addSubview:_sourceLabel];
    
    //图片
    _imageView = [[ZoomImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_imageView];
    
    //原微博背景图片,timeline_rt_border_9.png
    _bgImageView = [[ThemeImageView alloc] initWithFrame:CGRectZero];
    //拉伸
    _bgImageView.leftCapWidth = 30;
    _bgImageView.topCapWidth = 30;
    
    _bgImageView.imgName = @"timeline_rt_border_9.png";
//    [self addSubview:_bgImageView];
    //将背景插入到最下面，不让会覆盖前面的视图
    [self insertSubview:_bgImageView atIndex:0];
    
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textLabel.font =   [UIFont systemFontOfSize: FontSize_Weibo(_layoutFrame.isDetail)] ;
    _sourceLabel.font =  [UIFont systemFontOfSize: FontSize_ReWeibo(_layoutFrame.isDetail)] ;
    
    
    WeiboModel *weiboModel = _layoutFrame.weiboModel;
    
//    设置整个weiboView的frame
//    self.frame = _layoutFrame.frame;
    
    _textLabel.frame = _layoutFrame.textFrame;
    _textLabel.text = weiboModel.text;
    
    if (weiboModel.reWeiboModel != nil) { // 说明有转发
        _bgImageView.hidden = NO;
        _sourceLabel.hidden = NO;
        
        //原微博
        _sourceLabel.text = weiboModel.reWeiboModel.text;
        _sourceLabel.frame = _layoutFrame.srTextFrame;
        
        _bgImageView.frame = _layoutFrame.bgImageFrame;
        //图片
        NSString *imageUrl = weiboModel.reWeiboModel.thumbnailImage;
        if (imageUrl != nil) {
            _imageView.hidden = NO;
            _imageView.frame = _layoutFrame.imageFrame;
            [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            //大图链接
            NSString *fullImageUrl = weiboModel.reWeiboModel.originalImage;
            _imageView.fullImageUrlString = fullImageUrl;
            
        }else {
            //没有图片的话
            _imageView.hidden = YES;
        }
    }else {
        //不是转发
        _bgImageView.hidden = YES;
        _sourceLabel.hidden = YES;
        
        //图片
        NSString *imageUrl = weiboModel.thumbnailImage;
        if (imageUrl != nil) {
            _imageView.hidden = NO;
            _imageView.frame = _layoutFrame.imageFrame;
            [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            //大图
            _imageView.fullImageUrlString = weiboModel.originalImage;
            
        }else {
            //没有图片的话
            _imageView.hidden = YES;
        }
    }
    
    
    //判断是否是gif图片
    if (_imageView.hidden == NO) {//有图片
        NSString *extension;
        UIImageView *iconView = _imageView.iconView;
        iconView.frame = CGRectMake(_imageView.width-24, _imageView.height-15, 24, 15);
        if (weiboModel.reWeiboModel != nil) { //有转发
            extension = [weiboModel.reWeiboModel.thumbnailImage pathExtension];
        }else { //没有转发
            extension = [weiboModel.thumbnailImage pathExtension];
        }
        
        if ([extension isEqualToString:@"gif"]) {
            _imageView.isGIF = YES;
            iconView.hidden = NO;
        }else{
            _imageView.isGIF = NO;
            iconView.hidden = YES;
        }
    }
}

//接受通知后
- (void)themeDidChange:(NSNotification *)notification {
    _textLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    _sourceLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
}

#pragma mark - wxlabel daili
//检索文本的正则表达式的字符串
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
{
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString *regex1 = @"@\\w+";
    
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}

//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel;{
//    return [UIColor redColor];
    return [[ThemeManager shareInstance] getThemeColor:@"Link_color"];
}
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel;{
    return [UIColor blueColor];
}

@end
