//
//  ViewController.m
//  被你大白了
//
//  Created by qingyun on 16/1/19.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVAudioSession.h>
#import <AudioToolbox/AudioSession.h>
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"

#import "iflyMSC/IFlyRecognizerViewDelegate.h"
#import "iflyMSC/IFlyRecognizerView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //通过appid连接讯飞语音服务器，换成你申请的appid
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,timeout=%@",@"569dac3e",@"20000"];
     //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
//    //创建合成对象，为单例模式
//    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
//    _iFlySpeechSynthesizer.delegate = self;
//    
//    //设置语音合成的参数
//    //合成的语速,取值范围 0~100
//    [_iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];
//    //合成的音量;取值范围 0~100
//    [_iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];
//    //发音人,默认为”xiaoyan”;可以设置的参数列表可参考个性化发音人列表
//    [_iFlySpeechSynthesizer setParameter:@"小燕" forKey:[IFlySpeechConstant VOICE_NAME]];
//    //音频采样率,目前支持的采样率有 16000 和 8000
//    [_iFlySpeechSynthesizer setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
//    ////asr_audio_path保存录音文件路径，如不再需要，设置value为nil表示取消，默认目录是documents
//    [_iFlySpeechSynthesizer setParameter:@"tts.pcm" forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
    
    //启动合成会话
    //[_iFlySpeechSynthesizer startSpeaking:@"您好，我是科大讯飞的小雅"];
    
    ////隐藏键盘，点击空白处
//    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
//    tapGr.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:tapGr];
    
    //重新集成
    _iflyRecognizerView = [[IFlyRecognizerView alloc]initWithCenter:self.view.center];
    _iflyRecognizerView.delegate = self;
    [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    //asr_audio_path保存录音文件名，如不再需要，设置value为nil表示取消，默认目录是documents
    [_iflyRecognizerView setParameter:@"asrview" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [_iflyRecognizerView start];//语音听写启动
    
    [self.view addSubview:_iflyRecognizerView];
    
}


//-(void)viewTapped:(UITapGestureRecognizer*)tapGr
//{
//    [self.textField resignFirstResponder];
//}



- (IBAction)Click:(UIButton *)sender {
    
    //启动合成会话
    //[_iFlySpeechSynthesizer startSpeaking:self.textField.text];
    
}



//#pragma mark - IFlySpeechSynthesizerDelegate

//合成结束，必须要实现此代理
-(void)onCompleted:(IFlySpeechError *)error
{
    
}


////开始播放
//- (void) onSpeakBegin
//{
//    
//}
//
////缓冲进度
//- (void) onBufferProgress:(int) progress message:(NSString *)msg
//{
//    NSLog(@"bufferProgress:%d,message:%@",progress,msg);
//}
//
////播放进度
//- (void) onSpeakProgress:(int) progress
//{
//    NSLog(@"play progress:%d",progress);
//}
//
////暂停播放
//- (void) onSpeakPaused
//{
//    
//}
//
////恢复播放
//- (void) onSpeakResumed
//{
//    
//}
//
////结束回调
//- (void) onCompleted:(IFlySpeechError *) error
//{
//    
//}



#pragma mark --语音听写

-(void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    
}


-(void)onError:(IFlySpeechError *)error
{
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
