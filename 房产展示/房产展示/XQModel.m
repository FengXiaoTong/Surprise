//
//  XQModel.m
//  房产展示
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "XQModel.h"

@implementation XQModel

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init] ) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)modelWithDictionary:(NSDictionary *)dict
{
    return  [[self alloc]initWithDictionary:dict];
}

@end
