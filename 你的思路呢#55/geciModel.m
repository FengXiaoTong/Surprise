//
//  geciModel.m
//  你的思路呢#55
//
//  Created by qingyun on 15/12/25.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "geciModel.h"
#import "SongNameModel.h"

@implementation geciModel

-(instancetype)initWithModel:(SongNameModel *)model
{
    if (self = [super init]) {
        NSString *lrcStr = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:model.kName ofType:@"lrc"] encoding:NSUTF8StringEncoding error:nil];
        
        // NSLog(@"===%@",lrcStr);
        
        NSArray *lrcArr = [lrcStr componentsSeparatedByString:@"\n"];
        //想看清楚lrcArr的内容，只需要打印一个就好
        //  NSLog(@"====lrcArr===%@",lrcArr);
        
        _lrcDic = [NSMutableDictionary dictionary];
        for (NSString *str in lrcArr) {
            NSArray *tempArr = [str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[:]"]];
            
            // NSLog(@">>>%@",tempArr);
            if (tempArr.count >= 4) {
                if ([tempArr[1]hasPrefix:@"0"]) {
                    float time = [tempArr[1] floatValue]* 60 +[tempArr[2]floatValue];//计算出每行歌词出现的时间秒数！
                    
                    //这部分才是歌词
                    NSString *lrc = tempArr[3];
                    
                                     
                  [_lrcDic setObject:lrc forKey:@(time)];
                   // NSLog(@"<<< %@",_lrcDic);
                }
            }
        }
        _keyArr = [[_lrcDic allKeys]sortedArrayUsingSelector:@selector(compare:)];
    }
    return self;  
}

+(instancetype)doWithModel:(SongNameModel *)model
{
    
    return [[geciModel alloc]initWithModel:model];
}
    



@end
