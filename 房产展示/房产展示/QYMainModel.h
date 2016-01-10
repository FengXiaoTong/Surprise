//
//  QYMainModel.h
//  DropDownMenu1508
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYMainModel : NSObject
@property (nonatomic, strong) NSString *area;//区域
@property (nonatomic, strong) NSArray *listarea;//商圈

//当前数据中选中状态
@property (nonatomic) BOOL isSelected;

//初始化方法
-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)modelWithDictionary:(NSDictionary *)dict;
@end
