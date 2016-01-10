//
//  QYMainModel.m
//  DropDownMenu1508
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import "QYMainModel.h"
#import "QYSubModel.h"
@implementation QYMainModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSString *title in self.listarea) {
            QYSubModel *subModel = [QYSubModel modelWithTitle:title];
            [array addObject:subModel];
        }
        
        self.listarea = array;
    }
    return self;
}

+(instancetype)modelWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}

@end
