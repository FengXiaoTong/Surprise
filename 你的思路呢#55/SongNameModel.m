//
//  SongNameModel.m
//  你的思路呢#55
//
//  Created by qingyun on 15/12/25.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "SongNameModel.h"

@implementation SongNameModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)modeWithDic:(NSDictionary *)dic
{

      return [[SongNameModel alloc]initWithDic:dic];
}


@end
