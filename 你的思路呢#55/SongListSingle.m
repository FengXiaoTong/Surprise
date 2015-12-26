//
//  SongListSingle.m
//  你的思路呢#55
//
//  Created by qingyun on 15/12/25.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "SongListSingle.h"
#import "SongNameModel.h"


@implementation SongListSingle


+(instancetype)shareSingle
{
    static SongListSingle *single;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        single = [[SongListSingle alloc]init];
    });
    return single;
}

//plist列表里面的 字典转模型

-(NSMutableArray *)songListArr
{
    if (_songListArr == nil) {
        
        NSArray *songArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"SongsInfos" ofType:@"plist"]];
        
        NSMutableArray *models = [NSMutableArray array];
        
        for (NSDictionary *dic in songArr) {
            SongNameModel *model = [SongNameModel modeWithDic:dic];
            
            [models addObject:model];
        }
        _songListArr = models;
    }
    return _songListArr;
}



@end
