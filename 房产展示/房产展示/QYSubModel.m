//
//  QYSubModel.m
//  DropDownMenu1508
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import "QYSubModel.h"

@implementation QYSubModel

-(instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        _title = title;
    }
    return self;
}

+(instancetype)modelWithTitle:(NSString *)title{
    return [[self alloc]initWithTitle:title];
}

@end
