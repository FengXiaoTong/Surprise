//
//  SongPlayerSingle.h
//  你的思路呢#55
//
//  Created by qingyun on 15/12/25.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class geciModel;

@protocol SongPlayerPro <NSObject>

-(void)sendCurrentTime:(NSTimeInterval)current;

-(void)updateLrcNotifi;

@end

typedef enum : NSUInteger {
    orderLoop,
    singelLoop,
    randowLoop,
    
} PlayType;

@interface SongPlayerSingle : NSObject

@property(nonatomic)NSTimeInterval currentTime;//当前播放时间，可以设置，获得，修改  所以写成属性

@property(nonatomic)NSTimeInterval durition;//总时长

@property(nonatomic)BOOL playOrNot;//播放状态

@property(nonatomic)PlayType playtype;//播放模式

@property(nonatomic)float voice;//音量

@property(nonatomic)NSInteger currentIndex;//当前播放音乐下标

@property(nonatomic,weak)id<SongPlayerPro>delegate;//设置代理属性

@property(nonatomic, strong)geciModel *gcModel;

-(void)nextSong;

-(void)prepare;

+(instancetype)shareSongHandle;

@end
