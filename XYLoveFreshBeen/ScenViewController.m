//
//  ScenViewController.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/26.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "ScenViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+Extension.h"
#import "ResultViewController.h"
#import "HomeViewController.h"

static const CGFloat kBorderW = 100;
static const CGFloat kMargin = 30;

@interface ScenViewController ()<AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic ,strong) AVCaptureSession *session;
@property (nonatomic ,strong) UIView *scanWindow;
@property (nonatomic ,weak)   UIView *maskView;
@property (nonatomic ,strong) UIImageView *scanNetImageView;

@end

@implementation ScenViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self resumenAnimation];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.clipsToBounds = YES;
    
    //1. 遮罩
    [self setUpTheMaskView];
    //2. 提示文本
    [self setUpTheTipTitleView];
    //3. 顶部导航
    [self setUpTheNavView];
    //4. 扫描区域
    [self setUpTheScanWindowView];
    //5. 开始动画
    [self beginScanning];
    
    [self setupBottomBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumenAnimation) name:@"EnterForeground" object:nil];
    // Do any additional setup after loading the view.
}

-(void)setUpTheMaskView{
    UIView *mask = [[UIView alloc]init];
    _maskView = mask;
    
    mask.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
    mask.layer.borderWidth = kBorderW;
    
    mask.bounds = CGRectMake(0, 0, self.view.sd_width + kBorderW +kMargin, self.view.sd_width + kBorderW +kMargin);
    mask.center = CGPointMake(self.view.sd_width * 5, self.view.sd_height * 0.5);
    mask.sd_y = 0;
    [self.view addSubview:mask];
    
}

-(void)setUpTheNavView{
    //1. 返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, 30, 25, 25);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_nor"] forState:UIControlStateNormal];
    backBtn.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    //2. 相册
    UIButton *albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    albumBtn.frame = CGRectMake(0, 0, 35, 49);
    albumBtn.center = CGPointMake(self.view.sd_width/2, 69/2.0);
    [albumBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_down"] forState:UIControlStateNormal];
    albumBtn.contentMode = UIViewContentModeScaleAspectFit;
    [albumBtn addTarget:self action:@selector(myAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:albumBtn];
    
    //3. 闪光灯
    UIButton *flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    flashBtn.contentMode = UIViewContentModeScaleAspectFit;
    [flashBtn addTarget:self action:@selector(openFlash:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:flashBtn];
}

-(void)setUpTheScanWindowView{
    CGFloat scanWindowH = self.view.sd_width - kMargin * 2;
    CGFloat scanWindowW = self.view.sd_width - kMargin * 2;
    _scanWindow = [[UIView alloc] initWithFrame:CGRectMake(kMargin, kBorderW, scanWindowW, scanWindowH)];
    _scanWindow.clipsToBounds = YES;
    [self.view addSubview:_scanWindow];
    
    _scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
    CGFloat buttonWH = 18;
    
    UIButton *topLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_1"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topLeft];
    
    UIButton *topRight = [[UIButton alloc] initWithFrame:CGRectMake(scanWindowW - buttonWH, 0, buttonWH, buttonWH)];
    [topRight setImage:[UIImage imageNamed:@"scan_2"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topRight];
    
    UIButton *bottomLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, scanWindowH - buttonWH, buttonWH, buttonWH)];
    [bottomLeft setImage:[UIImage imageNamed:@"scan_3"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomLeft];
    
    UIButton *bottomRight = [[UIButton alloc] initWithFrame:CGRectMake(topRight.sd_x, bottomLeft.sd_y, buttonWH, buttonWH)];
    [bottomRight setImage:[UIImage imageNamed:@"scan_4"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomRight];

}

-(void)beginScanning{
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) {
        return;
    }
    //创建输入流
    AVCaptureMetadataOutput *outPut = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置有效扫描区域
    CGRect scanCrop = [self getScanCrop:_scanWindow.bounds readerViewBounds:self.view.frame];
    outPut.rectOfInterest = scanCrop;
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_session addInput:input];
    [_session addOutput:outPut];
    //设置扫描支持的编码格式（如下设置条形码和二维码兼容）
    outPut.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                   AVMetadataObjectTypeEAN13Code,
                                   AVMetadataObjectTypeEAN8Code,
                                   AVMetadataObjectTypeCode128Code
                                   ];
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [_session startRunning];
    
}

#pragma mark -- delegeta
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        NSString *result;
        if ([[metadataObject type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadataObject.stringValue;
        }
        [self readResult:result];
    }
}
-(void)readResult:(NSString *)str{
    
    ResultViewController *result = [[ResultViewController alloc]init];
    result.urlStr = str;
    [self.navigationController pushViewController:result animated:YES];
}
#pragma mark ---设置有效扫描区域
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds{
    CGFloat x,y,width,height;
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
}

#pragma mark --返回
-(void)disMiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --开关闪光灯
-(void)openFlash:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        [self turnTorchOn:YES];
    }else{
        [self turnTorchOn:NO];
    }
}
-(void)turnTorchOn:(BOOL)on{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]) {
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            }else{
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
    
}
#pragma mark -- 我的相册
-(void)myAlbum{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        //设置代理
        picker.delegate = self;
        
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        [self setUpTheUIAlertController:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！"];
    }
}
#pragma mark -- imagePickerController delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //1. 获取选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //2. 初始化一个监测器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    [picker dismissViewControllerAnimated:YES completion:^{
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count >= 1) {
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            [self setUpTheUIAlertController:scannedResult];
        }else{
            [self setUpTheUIAlertController:@"该图片没有包含一个二维码！"];
        }
    }];
}
-(void)setUpTheUIAlertController:(NSString *)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:alertAction];
    [alertController addAction:alertAction1];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)setUpTheTipTitleView{
    // 1. 补充遮罩
    UIView *mask = [[UIView alloc]initWithFrame:CGRectMake(0, _maskView.sd_y + _maskView.sd_height, self.view.sd_width, kBorderW)];
    mask.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:mask];
    
    //2. 操作提示
    UILabel *tipLbale = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.sd_height*0.9-kBorderW*2, self.view.bounds.size.width, kBorderW)];
    tipLbale.text = @"将取景框对准二维码，即可自动扫描";
    tipLbale.textColor = [UIColor whiteColor];
    tipLbale.textAlignment = NSTextAlignmentCenter;
    tipLbale.numberOfLines = 2;
    tipLbale.lineBreakMode = NSLineBreakByWordWrapping;
    tipLbale.font = [UIFont systemFontOfSize:12];
    tipLbale.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipLbale];
}

- (void)setupBottomBar

{
    //1.下边栏
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.sd_height , self.view.sd_width, self.view.sd_height * 0.1)];
    bottomBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
    [self.view addSubview:bottomBar];
    

}


-(void)resumenAnimation{
    CAAnimation *anim = [_scanNetImageView.layer animationForKey:@"translationAnimation"];
    if (anim) {
        // 1. 将动画的时间偏移量作为暂停时的时间点
        CFTimeInterval pauseTime = _scanNetImageView.layer.timeOffset;
        // 2. 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        // 3. 要把偏移时间清零
        [_scanNetImageView.layer setTimeOffset:0.0];
        // 4. 设置图层的开始动画时间
        [_scanNetImageView.layer setBeginTime:beginTime];
        [_scanNetImageView.layer setSpeed:1.0];
        
    }else{
        CGFloat scanNetImageViewH = 241;
        CGFloat scanWindowH = self.view.sd_width - kMargin * 2;
        CGFloat scanNetImageView = _scanWindow.sd_width;
        
        _scanNetImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageView, scanNetImageViewH);
        CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
        scanNetAnimation.keyPath = @"transform.translation.y";
        scanNetAnimation.byValue = @(scanWindowH);
        scanNetAnimation.duration = 1.0;
        scanNetAnimation.repeatCount = MAXFLOAT;
        [_scanNetImageView.layer addAnimation:scanNetAnimation forKey:@"translationAnimation"];
        [_scanWindow addSubview:_scanNetImageView];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
