//
//  SendViewController.m
//  项目二
//
//  Created by mac on 15/9/17.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

//NSLocationWhenInUseUsageDescription  BOOL YES
//NSLocationAlwaysUsageDescription         string “提示描述”

#import "SendViewController.h"
#import "ThemeButton.h"
#import "MMDrawerController.h"
#import "DataService.h"

@interface SendViewController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZoomImageViewDelegate,CLLocationManagerDelegate,FaceViewDelegate>
{
    UIImage *_sendImage;
}
@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor redColor];
    
    [self createNavItems];
    
    [self _createToolBarView];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//初始化
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        //添加通知，监听键盘弹出
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHidden:) name:UIKeyboardDidHideNotification object:nil];
        
    }
    return self;
}
////键盘隐藏时，工具栏随着隐藏
//- (void)keyBoardDidHidden:(NSNotification *)notification{
//    _toolBarView.bottom = kScreenHeight;
//}
#pragma mark - 键盘frame改变通知
- (void)keyBoardWillChange:(NSNotification *)notification{
    //根据键盘高度计算工具栏按钮的高度
    NSLog(@"%@",notification);
    //1 取出键盘的frame
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [value CGRectValue];
    //2 键盘高度
    CGFloat height = frame.size.height;
    
    //3 调整视图的高度
    _toolBarView.bottom = kScreenHeight - height - 64;

    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //导航栏不透明，当导航栏不透明的时候 ，子视图的y的0位置在导航栏下面
    self.navigationController.navigationBar.translucent = NO;
    //弹出键盘
    [_textView becomeFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //弹出键盘
    [_textView becomeFirstResponder];
}
//创建导航栏按钮
- (void)createNavItems{
    //1 左边关闭按钮
    ThemeButton *closeButton = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    closeButton.normalImageName = @"button_icon_close.png";
    [closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItem = button;
    
    //2 发送按钮
    ThemeButton *sendButton = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    sendButton.normalImageName = @"button_icon_ok.png";
    [sendButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = button1;
    
}

#pragma mark - 创建textview 和 工具栏视图
- (void)_createToolBarView{
    //1 文本输入视图
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.backgroundColor = [UIColor grayColor];
    _textView.editable = YES;
    
    //设置圆角
    _textView.layer.cornerRadius = 10;
    _textView.layer.borderColor = [[UIColor blackColor]CGColor];
    _textView.layer.borderWidth = 2;
    
    [self.view addSubview:_textView];
    
    
    //工具栏,,工具栏的frame根据键盘高度改变而设置
    _toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
    _toolBarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_toolBarView];
    
    //向工具栏上添加按钮视图
    NSArray *imgs = @[@"compose_toolbar_1.png",
                      @"compose_toolbar_4.png",
                      @"compose_toolbar_3.png",
                      @"compose_toolbar_5.png",
                      @"compose_toolbar_6.png"];
    CGFloat buttonWidth = kScreenWidth / imgs.count;
    for (int i = 0; i < imgs.count; i++) {
        
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(buttonWidth*i, 20, buttonWidth, 33)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        button.normalImageName = imgs[i];
        [_toolBarView addSubview:button];
    }
    
    
    //3 创建label。显示位置信息
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , 30)];
    _locationLabel.hidden = YES;
    _locationLabel.font = [UIFont systemFontOfSize:15];
//    _locationLabel.backgroundColor = [UIColor grayColor];
    _locationLabel.textColor = [UIColor blackColor];
    
    [_toolBarView addSubview:_locationLabel];
}
//工具栏按钮动作响应
- (void)buttonAction:(UIButton *)button{
    if (button.tag == 100) {      //拍照 选择照片
        //拍照或选择照片
        [self _selectPhoto];

    }else if (button.tag == 101){ //#

        
    }else if (button.tag == 102){ //@
        
    }else if (button.tag == 103){ //定位
        [self _location];
        
    }else if (button.tag == 104){ //表情
        BOOL isFiseResponder = _textView.isFirstResponder;
        
        if (isFiseResponder) {
            [_textView resignFirstResponder];
            [self _showFaceView];
        }else {
            [self _hideFaceView];
            [_textView becomeFirstResponder];
        }
        
    }
}

//判断拍照还是选择照片
- (void)_selectPhoto{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    
//    [self.view addSubview:actionSheet];
    [actionSheet showInView:self.view];
    
}
#pragma mark - UIActionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex == 0) {  //拍照
        sourceType = UIImagePickerControllerSourceTypeCamera;
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"摄像头无法使用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alter show];
            
            return;
        }
    }else if (buttonIndex == 1) { //选择照片
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
    }else {
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - 选择照片 代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 1 弹出相册控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 2 取出照片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // 3 显示缩略图
    if (_zoomImageView == nil) {
        _zoomImageView = [[ZoomImageView alloc] initWithImage:image];
        _zoomImageView.frame = CGRectMake(10, _textView.bottom+10, 80, 80);
        _zoomImageView.delegate = self;
        [self.view addSubview:_zoomImageView];
    }
    
    _zoomImageView.image = image;
    _sendImage = image;
}
#pragma mark - 缩略图放大代理方法
//缩小
- (void)imageWillZoomIn:(ZoomImageView *)imageView {
    [_textView resignFirstResponder];
}
//放大
- (void)imageWillZoomOut:(ZoomImageView *)imageView{
    [_textView becomeFirstResponder];
}
// 发送微博动作
- (void)sendAction{
    NSString *text = _textView.text;
    NSString *error = nil;
    if (text.length == 0) {
        error = @"发送内容为空";
    }else if (text.length > 140){
        error = @"微博内容超过140字";
    }
    if (error != nil) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alterView show];
    }
    
    //发送微博
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:text forKey:@"status"];
    
    
//    AFHTTPRequestOperation *operation = 
    [DataService sendWeibo:text image:_sendImage block:^(id result) {
        NSLog(@"result = %@",result);
        [self showStatusTip:@"发送完毕" show:NO operration:nil];
    }];
    
    [self showStatusTip:@"正在发送" show:YES operration:nil];
    
    [self closeAction];
}
//关闭动作
- (void)closeAction{
    //通过uiwindow找到 MMDRawer
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if ([window.rootViewController isKindOfClass:[MMDrawerController class]]) {
        MMDrawerController *mmDrawer = (MMDrawerController *)window.rootViewController;
        
        [mmDrawer closeDrawerAnimated:YES completion:nil];
    }
    //关闭键盘
    [_textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//定位
- (void)_location{
    
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        
        //版本判断
        if (kVersion > 8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    //定位精度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //设置代理
    _locationManager.delegate = self;
    //开始定位
    [_locationManager startUpdatingLocation];
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //停止定位
    [manager stopUpdatingLocation];
    //取得地理位置信息
    CLLocation *location = [locations lastObject];
    //获取经纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"经度：%lf,纬度:%lf",coordinate.longitude,coordinate.latitude);
    
    //地理位置反编码，通过经纬度获得地理位置
    //https://api.weibo.com/2/location/geo/geo_to_address.json
    NSString *coordinateStr = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:coordinateStr forKey:@"coordinate"];
    
    __weak SendViewController *weakSelf = self;
    [DataService requestAFUrl:geo_to_address httpMethod:@"GET" params:params data:nil block:^(id result) {
        NSArray *geos = result[@"geos"];
        if (geos.count > 0) {
            NSDictionary *geoDic = [geos lastObject];
            NSString *address = geoDic[@"address"];
            NSLog(@"address = %@",address);
            
            __strong SendViewController *strongSelf = weakSelf;
            strongSelf->_locationLabel.hidden = NO;
            
            strongSelf->_locationLabel.text = address;
        }
    }];
    //ios内置反编码
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *place = [placemarks lastObject];
        NSLog(@"%@",place.name);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 表情处理
- (void)faceDidSelect:(NSString *)text {
    _textView.text = [NSString stringWithFormat:@"%@%@",_textView.text,text];
}
- (void)_showFaceView{
    //创建表情面板
    if (_faceViewPanel == nil) {
        _faceViewPanel = [[FaceScrollView alloc] init];
        [_faceViewPanel setFaceViewDelegate:self];
        //放到底部
        _faceViewPanel.top = kScreenHeight - 64;
        [self.view addSubview:_faceViewPanel];
    }
    
    //显示表情
    [UIView animateWithDuration:0.3 animations:^{
        _faceViewPanel.bottom = kScreenHeight-64;
        //重新布局工具栏输入框
        _toolBarView.bottom = _faceViewPanel.top;
    }];
}
//隐藏表情
- (void)_hideFaceView{
    [UIView animateWithDuration:0.3 animations:^{
        _faceViewPanel.top = kScreenHeight-64;
    }];
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
