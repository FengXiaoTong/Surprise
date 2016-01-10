//
//  QYSelectedMenuModel.m
//  DropDownMenu1508
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import "QYSelectedMenuModel.h"

@implementation QYSelectedMenuModel

-(instancetype)initWithMainRow:(NSInteger)mainRow subRow:(NSInteger)subRow{
    if (self = [super init]) {
        _mainRow = mainRow;
        _subRow = subRow;
    }
    return self;
}

+(instancetype)modelWithMainRow:(NSInteger)mainRow subRow:(NSInteger)subRow{
    return [[self alloc]initWithMainRow:mainRow subRow:subRow];
}
@end
