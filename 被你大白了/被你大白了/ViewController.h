//
//  ViewController.h
//  被你大白了
//
//  Created by qingyun on 16/1/19.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlyRecognizerViewDelegate.h"
#import "iflyMSC/IFlyRecognizerView.h"
#import "iflyMSC/IFlySpeechRecognizerDelegate.h"
#import "iflyMSC/IFlySpeechRecognizer.h"


@class IFlySpeechSynthesizer;
@class IFlyDataUploader;

@interface ViewController : UIViewController<IFlySpeechSynthesizerDelegate,IFlyRecognizerViewDelegate>

@property (nonatomic, strong)IFlyRecognizerView *iflyRecognizerView;

@end

