//
//  WeiboViewLayoutFrame.m
//  项目二
//
//  Created by mac on 15/9/11.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "WeiboViewLayoutFrame.h"
#import "WXLabel.h"
@implementation WeiboViewLayoutFrame

- (void)setWeiboModel:(WeiboModel *)model {
    if (_weiboModel != model) {
        _weiboModel = model;
        [self _layoutFrame];
    }
}

//- (void)layoutFrame {
//    //根据weibomodel计算
//    //1 微博视图的frame
//    self.frame  = CGRectMake(55, 40, kScreenWidth-65, 0);
//    
//    //2 微博内容的frame
//    //1》计算微博内容的宽度
//    CGFloat  textWidth = CGRectGetWidth(self.frame) - 20;
//    //2> 计算微博内容的高度
//    NSString *text = self.weiboModel.text;
//    CGFloat textHeight = [WXLabel getTextHeight:16 width:textWidth text:text linespace:5.0];
//    
//    self.textFrame = CGRectMake(10, 0, textWidth, textHeight);
//    
//    //3 原微博内容的frame
//    if (self.weiboModel.reWeiboModel != nil) { //说明有转发
//        NSString *reText = self.weiboModel.reWeiboModel.text;
//        
//        //1> 宽度
//        CGFloat reTextWidth = textWidth - 20;
//        //2> 高度
//        CGFloat textHeight = [WXLabel getTextHeight:14 width:reTextWidth text:reText linespace:5.0];
//        //3> 坐标
//        CGFloat Y = CGRectGetMaxY(self.textFrame)+10;
//        self.srTextFrame = CGRectMake(20, Y, reTextWidth, textHeight);
//        //4> 原微博的图片
//        NSString *thumbnailImage = self.weiboModel.reWeiboModel.thumbnailImage;
//        if (thumbnailImage != nil) {
//            CGFloat Y = CGRectGetMaxY(self.srTextFrame)+10;
//            CGFloat X = CGRectGetMinX(self.srTextFrame);
//            
//            self.imageFrame = CGRectMake(X, Y, 80, 80);
//        }
//        
//        //4> 原微博的背景
//        CGFloat bgX = CGRectGetMinX(self.textFrame);
//        CGFloat bgY = CGRectGetMaxY(self.textFrame);
//        CGFloat bgWidth = CGRectGetWidth(self.textFrame);
//        CGFloat bgHeight = CGRectGetMaxY(self.srTextFrame);
//        
//        if (thumbnailImage != nil) {
//            bgHeight = CGRectGetMaxY(self.imageFrame);
//        }
//        bgHeight -= CGRectGetMaxY(self.textFrame);
//        bgHeight += 10;
//
//        self.bgImageFrame = CGRectMake(bgX, bgY, bgWidth, bgHeight);
//    }else { //说明没有转发
//        //判断自己是否有微博图片
//        NSString *thumbnailImage = self.weiboModel.thumbnailImage;
//        if (thumbnailImage != nil) {
//            CGFloat imX = CGRectGetMinX(self.textFrame);
//            CGFloat imY = CGRectGetMaxY(self.textFrame)+10;
//            self.imageFrame = CGRectMake(imX, imY, 80, 80);
//        }
//    }
//    
//    //计算微博视图的高度，微博视图最底部子视图的y坐标
//    CGRect f = self.frame;
//    if (self.weiboModel.reWeiboModel != nil) {
//        f.size.height = CGRectGetMaxY(_bgImageFrame);
//    }
//    else if (self.weiboModel.thumbnailImage != nil) {
//        f.size.height = CGRectGetMaxY(_imageFrame);
//    }else {
//        f.size.height = CGRectGetMaxY(_textFrame);
//    }
//    self.frame = f;
//}


- (void)_layoutFrame{
    
    
    //根据 weiboModel计算
    CGFloat weiboFontSize = FontSize_Weibo(self.isDetail);
    CGFloat reWeiboFontSize = FontSize_ReWeibo(self.isDetail);
    
    
    //1.微博视图的frame
    if (self.isDetail) {
        self.frame = CGRectMake(0, 0, kScreenWidth, 0);
    }else{
        self.frame = CGRectMake(55, 40, kScreenWidth-65, 0);
        
    }
    
    //2.微博内容的frame
    //1>计算微博内容的宽度
    CGFloat textWidth = CGRectGetWidth(self.frame)-20;
    
    //2>计算微博内容的高度
    NSString *text = self.weiboModel.text;
    CGFloat textHeight = [WXLabel getTextHeight:weiboFontSize width:textWidth text:text linespace:5.0];
    
    self.textFrame = CGRectMake(10, 0, textWidth, textHeight);
    
    //3.原微博的内容frame
    if (self.weiboModel.reWeiboModel != nil) {
        NSString *reText = self.weiboModel.reWeiboModel.text;
        
        //1>宽度
        CGFloat reTextWidth = textWidth-20;
        //2>高度
        
        CGFloat textHeight = [WXLabel getTextHeight:reWeiboFontSize width:reTextWidth text:reText linespace:5.0];
        
        //3>Y坐标
        CGFloat Y = CGRectGetMaxY(self.textFrame)+10;
        self.srTextFrame = CGRectMake(20, Y, reTextWidth, textHeight);
        
        //4.原微博的图片
        NSString *thumbnailImage = self.weiboModel.reWeiboModel.thumbnailImage;
        if (thumbnailImage != nil) {
            
            CGFloat Y = CGRectGetMaxY(self.srTextFrame)+10;
            CGFloat X = CGRectGetMinX(self.srTextFrame);
#warning 设置微博图片的尺寸
            if (self.isDetail) {
                self.imageFrame = CGRectMake(X, Y, CGRectGetWidth(self.frame)-20, 160);
            } else {
                self.imageFrame = CGRectMake(X, Y, 80, 80);
            }
        }
        
        //4.原微博的背景
        CGFloat bgX = CGRectGetMinX(self.textFrame);
        CGFloat bgY = CGRectGetMaxY(self.textFrame);
        CGFloat bgWidth = CGRectGetWidth(self.textFrame);
        CGFloat bgHeight = CGRectGetMaxY(self.srTextFrame);
        if (thumbnailImage != nil) {
            bgHeight = CGRectGetMaxY(self.imageFrame);
        }
        bgHeight -= CGRectGetMaxY(self.textFrame);
        bgHeight += 10;
        
        self.bgImageFrame = CGRectMake(bgX, bgY, bgWidth, bgHeight);
        
    } else {
        //微博图片
        NSString *thumbnailImage = self.weiboModel.thumbnailImage;
        if (thumbnailImage != nil) {
            
            CGFloat imgX = CGRectGetMinX(self.textFrame);
            CGFloat imgY = CGRectGetMaxY(self.textFrame)+10;
#warning 微博正文图片尺寸调整
            if (self.isDetail) {
                self.imageFrame = CGRectMake(imgX , imgY, CGRectGetWidth(self.frame)-40, 160);
            } else {
                self.imageFrame = CGRectMake(imgX , imgY, 80, 80);
            }
        }
    }
    
    //计算微博视图的高度：微博视图最底部子视图的Y坐标
    CGRect f = self.frame;
    if (self.weiboModel.reWeiboModel != nil) {
        f.size.height = CGRectGetMaxY(_bgImageFrame);
    }
    else if(self.weiboModel.thumbnailImage != nil) {
        f.size.height = CGRectGetMaxY(_imageFrame);
    }
    else {
        f.size.height = CGRectGetMaxY(_textFrame);
    }
    self.frame = f;
    
    
}
@end
