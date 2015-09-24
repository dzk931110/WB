//
//  ZoomImageView.m
//  项目二
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "ZoomImageView.h"
#import "MBProgressHUD.h"
#import <ImageIO/ImageIO.h>
#import "UIImage+GIF.h"

@implementation ZoomImageView{
    NSURLConnection *_connection;
    double _length;
    NSMutableData *_data;
    MBProgressHUD *_hud;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self _initTap];
        [self _createGif];
    }
    return self;
}
- (instancetype)initWithImage:(UIImage *)image{
    if (self = [super initWithImage:image]) {
        [self _initTap];
        [self _createGif];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self _initTap];
        [self _createGif];
    }
    return self;
}
- (void)_initTap{
    //01 开启
    self.userInteractionEnabled = YES;

    //02 手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomIn)];
    [self addGestureRecognizer:tap];
    
    //03 保持比例
    self.contentMode = UIViewContentModeScaleAspectFit;
    
}
//放大
- (void)zoomIn{
    //调用代理的方法，通知代理
    if ([self.delegate respondsToSelector:@selector(imageWillZoomIn:)]) {
        //传值
        [self.delegate imageWillZoomIn:self];
    }
    
    self.hidden = YES;
    
    //01 创建大图浏览的scrollerview
    [self _createView];
    
    //02 计算fullimageView的frame
    //把自己相对于父视图的frame 转换成相对于 window的frame
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    _fullImageView.frame = frame;
    
    //03 添加动画放大
    [UIView animateWithDuration:0.3 animations:^{
        _fullImageView.frame = _scrollview.frame;
    } completion:^(BOOL finished) {
        _fullImageView.backgroundColor = [UIColor clearColor];
        [self _downLoadImage];
    }];
    
    
    
}
- (void)_downLoadImage{
    //04 请求网络
    if (self.fullImageUrlString.length > 0) {
        if (_hud == nil) {
            _hud = [MBProgressHUD showHUDAddedTo:_scrollview animated:YES];
            _hud.mode = MBProgressHUDModeAnnularDeterminate;
            _hud.progress = 0.0;
        }
        
        NSURL *url = [NSURL URLWithString:_fullImageUrlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
        
        _connection = [NSURLConnection connectionWithRequest:request delegate:self];
        
    }
}
//缩小
- (void)zoomOut{
    
    //调用代理的方法，通知代理
    if ([self.delegate respondsToSelector:@selector(imageWillZoomOut:)]) {
        //传值
        [self.delegate imageWillZoomOut:self];
    }
    //取消网络下载
    [_connection cancel];
    
    self.hidden = NO;
    
//    _fullImageView.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.3 animations:^{
        _scrollview.backgroundColor = [UIColor clearColor];
        CGRect frame = [self convertRect:self.bounds toView:self.window];
        _fullImageView.frame = frame;
        
        //如果scroller已经偏移，则偏移量也得计算
        _fullImageView.top += _scrollview.contentOffset.y;
        
    } completion:^(BOOL finished) {
        [_scrollview removeFromSuperview];
        _scrollview = nil;
        _fullImageView = nil;
        _hud = nil;
    }];
    
}
- (void)_createGif{
    //05 如果是gif，设置右下角图片
    _iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconView.hidden = YES;
    _iconView.image = [UIImage imageNamed:@"timeline_gif.png"];
    [self addSubview:_iconView];
}
- (void)_createView{
    if (_scrollview == nil) {
        //01 创建scrollerview
        _scrollview = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollview.backgroundColor = [UIColor blackColor];
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        [self.window addSubview:_scrollview];
        
        //02 创建大图
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullImageView.userInteractionEnabled = YES;
        _fullImageView.image = self.image;
        
        [_scrollview addSubview:_fullImageView];
        
        //03 添加缩小手势 点击返回
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOut)];
        [_scrollview addGestureRecognizer:tap];
     
        //添加捏合 可放大缩小查看
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
        [_scrollview addGestureRecognizer:pinch];
        
        //04 长按手势 将图片保存到相册
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [_scrollview addGestureRecognizer:longPress];
        


    }
}
//长按
- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存到相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterView show];
    }
}
//警告视图
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        /**
         *  长按保存图片到相册
         */
        UIImageWriteToSavedPhotosAlbum(_fullImageView.image, nil, nil, nil);
    }
}

//照片保存成功调用的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.labelText = @"保存完成";
    
    //持续1.5s隐藏
    [_hud hide:YES afterDelay:1.5];
}

//捏合
- (void)pinchAction:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        _fullImageView.transform = CGAffineTransformMakeScale(pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    }else if (pinchGestureRecognizer.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.3 animations:^{
            _fullImageView.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark - 网络下载监控
//服务器响应请求
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    //01 取得相应头
    NSDictionary *headerFields = [httpResponse allHeaderFields];
    
    //02 获取文件大小
    NSString *lengthStr = [headerFields objectForKey:@"Content-Length"];
    _length = [lengthStr doubleValue];
    
    _data = [[NSMutableData alloc] init];
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
    
    CGFloat progress = _data.length / _length;
    _hud.progress = progress;
    NSLog(@"progress = %f",progress);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    //下载完成，隐藏hud
    _hud.hidden = YES;
    
    UIImage *image = [UIImage imageWithData:_data];
    _fullImageView.image = image;
    
    //长图的尺寸处理
    CGFloat length = image.size.height / image.size.width * kScreenWidth;
    
    if (length > kScreenHeight) {
        [UIView animateWithDuration:0.6 animations:^{
            _fullImageView.height = length;
            _scrollview.contentSize = CGSizeMake(kScreenWidth, length);
        }];
    }
    
    //播放gif动态图
    if (self.isGIF) {
        [self gifImageShow];
    }
}

- (void)gifImageShow{
    //01 webview播放
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:_scrollview.bounds];
//    webView.userInteractionEnabled = NO;
//    webView.scalesPageToFit = YES;
//    
//    [webView loadData:_data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    [_scrollview addSubview:webView];
    
    //02 使用imageID 提取gif中所有帧de图片进行播放
    //import <ImageIO/ImageIO.h>
    //>>创建图片源
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)_data, NULL);
    //>>获取图片源中的图片个数
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (size_t i = 0; i < count; i++) {
        //>> 获取每一张图片
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        UIImage *uiImage = [UIImage imageWithCGImage:image];
        [images addObject:uiImage];
        CGImageRelease(image);
    }
    
    //03  使用第三方框架如SDWebImage 封装的gif播放
//    _fullImageView.image = [UIImage sd_animatedGIFWithData:_data];
    
    //04 imageview 播放图片数组
    //04>>1
//    _fullImageView.animationImages = images;
//    _fullImageView.animationDuration = images.count*0.1;
//    [_fullImageView startAnimating];
    
    //04>>2
    UIImage *animatedImage = [UIImage animatedImageWithImages:images duration:images.count*0.1];
    _fullImageView.image = animatedImage;
}

@end
