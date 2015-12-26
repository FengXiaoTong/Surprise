//
//  SongPlayerSingle.m
//  你的思路呢#55
//
//  Created by qingyun on 15/12/25.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "SongPlayerSingle.h"
#import <AVFoundation/AVFoundation.h>
#import "SongNameModel.h"
#import "SongListSingle.h"
#import <MediaPlayer/MediaPlayer.h>
#import "geciModel.h"

@interface SongPlayerSingle ()<AVAudioPlayerDelegate>
//创建类别
@property(nonatomic, strong)AVAudioPlayer *player;

@property(nonatomic, strong)NSTimer *timer;
@end


@implementation SongPlayerSingle
@synthesize voice = _voice , playOrNot = _playOrNot ,currentTime = _currentTime;

+(instancetype)shareSongHandle
{
    static  SongPlayerSingle *single;
    static  dispatch_once_t once;
    dispatch_once(&once, ^{
        
        single = [[SongPlayerSingle alloc]init];
        
        single.currentIndex = -10;
    });

    return single;
}


-(void)setCurrentIndex:(NSInteger )currentIndex
{
    if (currentIndex!= -10) {
        if (_currentIndex == currentIndex) {
            return;
        }
        SongNameModel *model = [SongListSingle shareSingle].songListArr[currentIndex];
        
        self.gcModel = [geciModel doWithModel:model];
        
        //初始化一个音乐播放器
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:model.kName withExtension:model.kType ] error:nil];
        
        _player.delegate = self;
        
        [_player prepareToPlay];
        
        [_player play];
        
        //更新歌词，（在播放器一开始播放之后）
        if (_delegate) {
            [_delegate updateLrcNotifi];
        }
        
        self.timer.fireDate = [NSDate distantPast];
    }
    _currentIndex = currentIndex;
}


-(void)setVoice:(float)voice
{
    _player.volume = voice;
    _voice = voice;
}

-(float)voice
{
    return _player.volume;
}

-(void)setCurrentTime:(NSTimeInterval)currentTime
{
    if (_currentTime != currentTime){
        
        _player.currentTime = currentTime;
    }
    _currentTime = currentTime;
}

-(NSTimeInterval)currentTime
{
    return _player.currentTime;
}

-(NSTimeInterval)durition
{
    return _player.duration;
}

-(BOOL)playOrNot
{
    return _player.isPlaying;//默认设置是播放的！
}

-(void)setPlayOrNot:(BOOL)playOrNot
{
    if (playOrNot) {
        self.timer.fireDate = [NSDate distantPast];
        [_player play];
    }else{
        self.timer.fireDate = [NSDate distantFuture];
        [_player pause];
    }
    _playOrNot = playOrNot;
}


-(NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    return _timer;

}

-(void)updateTimer
{
    //需要传值，更新进度条的值，所以三种方法传值：block块，代理，和通知中心！
    
    if (_delegate) {
        [_delegate sendCurrentTime:self.currentTime];
    }else{
        self.timer.fireDate = [NSDate distantFuture];//关闭计时器
    }
}

-(void)setDelegate:(id<SongPlayerPro>)delegate
{
    if (delegate!= _delegate) {
        if (self.playOrNot) {
            self.timer.fireDate = [NSDate distantPast];//启动计时器
        }
    }
    _delegate = delegate;
}


-(void)nextSong
{
    self.currentIndex = (self.currentIndex + 1)%([SongListSingle shareSingle].songListArr.count);
}


-(void)prepare
{
    if (self.currentIndex == 0) {
        self.currentIndex = [SongListSingle shareSingle].songListArr.count -1;
    }
    self.currentIndex = self.currentIndex - 1;
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //播放器完成播放的时候，就是说播放完当前的一首歌！
    if (flag) {
        switch (_playtype) {
            case orderLoop :
            {
                [self nextSong];
            }
                break;
                
            case singelLoop :
            {
                NSInteger temp = self.currentIndex;
                self.currentIndex = -10;
                self.currentIndex = temp;
            }
                
                break;
                
            case randowLoop:
            {
                self.currentIndex = arc4random()%[SongListSingle shareSingle].songListArr.count;
            }
                break;
                
            default:
                break;
        }
    }
}

@end
