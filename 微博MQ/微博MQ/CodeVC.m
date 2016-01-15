////
////  CodeVC.m
////  WeiBo1508
////
////  Created by qingyun on 16/1/4.
////  Copyright © 2016年 hnqingyun. All rights reserved.
////
//
//#import "CodeVC.h"
//#import <AVFoundation/AVFoundation.h>
//
//@interface CodeVC ()<AVCaptureMetadataOutputObjectsDelegate>
//@property (weak, nonatomic) IBOutlet UIView *preView;
//
//@property (nonatomic, strong)AVCaptureDevice *device;//抽象的设备
//@property (nonatomic, strong)AVCaptureDeviceInput *input;//连接设备的输入通道
//@property (nonatomic, strong)AVCaptureSession *session;
//@property (nonatomic, strong)AVCaptureMetadataOutput *output;//原数据输出
//
//@property (nonatomic, strong)NSString *resultUrl;//扫描到的结果；
//
//@property (nonatomic, strong)UIImageView * codeBoundImageView;//四角图片
//@property (nonatomic, strong)UIImageView * imageView;
//
//@property (nonatomic, strong)NSTimer *timer;
//
//@end
//
//@implementation CodeVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    //添加二维码扫描的边框
//    UIImage *image = [UIImage imageNamed:@"qrcode_border"];
//    //转化成可拉伸的图片
//    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(25, 25, 26, 26)];
//    
//    UIImageView *border = [[UIImageView alloc] initWithImage:image];
//    
//    //方形，计算宽度，x = y = 70；
//    
//    NSInteger w = [[UIScreen mainScreen] bounds].size.width - 70 *2;
//    border.frame = CGRectMake(70, 70+ 70, w, w);
//    [self.view addSubview:border];
//    self.codeBoundImageView = border;
//    //动画View
//    UIImageView *inamationView = [[UIImageView alloc] initWithFrame:border.bounds];
//    [border addSubview:inamationView];
//    border.clipsToBounds = YES;
//    [inamationView setImage:[UIImage imageNamed:@"qrcode_scanline_qrcode"]];
//    self.imageView = inamationView;
//    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(changeImage:) userInfo:nil repeats:YES];
//    
//}
//
//-(void)changeImage:(NSTimer *)timer{
//    //改变frame，用以产生动画
//    
//    self.imageView.frame = CGRectOffset(self.imageView.frame, 0, 1.5);
//    
//    if (self.imageView.frame.origin.y >= self.codeBoundImageView.frame.size.height - 10) {
//        self.imageView.frame = CGRectOffset(self.codeBoundImageView.bounds, 0, -self.codeBoundImageView.frame.size.height);
//    
//    }
//    
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self read];//开启二维码扫描
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self stop];//停止二维码扫描
//}
//
//-(void)read{
//    //获取设备
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    self.device = device;
//    
//    NSError *error;
//    
//    //创建连接通道
//    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
//    if (error) {
//        NSLog(@"%@", error);
//    }
//    self.input = input;
//    
//    //创建输出通道
//    
//    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
//    //设置输出的delegate
//    dispatch_queue_t queue =dispatch_queue_create("myQueue", NULL);
//    [output setMetadataObjectsDelegate:self queue:queue];
//    self.output = output;
//    //创建session，连接input和output 设置采集信息的处理
//    self.session = [[AVCaptureSession alloc] init];
//    [self.session addInput:self.input];
//    [self.session addOutput:self.output];
//    
//    //取出所有的支持的类型
//    NSMutableArray *result =[NSMutableArray arrayWithArray:self.output.availableMetadataObjectTypes];
//    //移除掉面部识别功能
//    [result removeObject:AVMetadataObjectTypeFace];
//    
//    //设置输出哪些信息，一定要在设置添加到session之后再设置
//    [self.output setMetadataObjectTypes:result];
//    
//    //设置预览效果
//    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
//    [layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
//    [layer setFrame:self.view.bounds];
//    
//    //将layer显示
//    [self.preView.layer addSublayer:layer];
//    
//    //绘制一张不透明，周围半透明的图片
//    //创建一张画布
//    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
//    //拿到画笔
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //先将整个图片涂成半透明
//    CGContextSetRGBFillColor(context, 0, 0, 0, .7f);
//    CGContextAddRect(context, self.view.bounds);
//    CGContextFillPath(context);
//    
//    //将中间涂成完全不透明的区域
//    CGContextSetRGBFillColor(context, 1, 1, 1, 1.f);
//    CGContextAddRect(context, self.codeBoundImageView.frame);
//    CGContextFillPath(context);
//    
//    //绘图完成，生成图片;
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    //创建一个用于遮罩的mask层,mask层自身不显示，但是影响到把mask层作为属性的layer显示，mask的每一点的透明度反作用到layer
//    CALayer *mask = [[CALayer alloc] init];
//    mask.bounds = self.preView.bounds;
//    mask.position = self.preView.center;
//    mask.contents = (__bridge id)image.CGImage;
//    layer.mask = mask;
//    layer.masksToBounds = YES;
//    //开始运行
//    [self.session startRunning];
//}
//
//
//
//-(void)stop{
//    //停止运行
//    [self.session stopRunning];
//    if (self.resultUrl) {
//        //用webView展示内容
//        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewVC"];
//        [vc setValue:self.resultUrl forKey:@"urlString"];
//        if (self.navigationController.viewControllers.count == 1) {
//             [self.navigationController pushViewController:vc animated:YES];
//        }
//    
//    }
//}
//- (IBAction)cancel:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}
//
//#pragma mark - delegate
//
//-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
//    
//    id object = metadataObjects.firstObject;
//    if ([object isKindOfClass:
//         //机器可识别的code对象
//         [AVMetadataMachineReadableCodeObject class]]) {
//        AVMetadataMachineReadableCodeObject *obj = (AVMetadataMachineReadableCodeObject *)object;
//        NSLog(@"%@", obj.stringValue);
//        self.resultUrl = obj.stringValue;
//    }
//    //在主线程中更新UI
//    [self performSelectorOnMainThread:@selector(stop) withObject:nil waitUntilDone:YES];
//    
//    
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
