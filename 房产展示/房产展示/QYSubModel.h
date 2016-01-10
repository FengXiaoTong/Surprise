//
//  QYSubModel.h
//  DropDownMenu1508
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYSubModel : NSObject
@property (nonatomic, strong) NSString *title;//从表文本
@property (nonatomic) BOOL isSelected;//从表选中状态

-(instancetype)initWithTitle:(NSString *)title;
+(instancetype)modelWithTitle:(NSString *)title;
@end
