//
//  QYSelectedMenuModel.h
//  DropDownMenu1508
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYSelectedMenuModel : NSObject
@property (nonatomic) NSInteger mainRow;
@property (nonatomic) NSInteger subRow;

-(instancetype)initWithMainRow:(NSInteger)mainRow subRow:(NSInteger)subRow;
+(instancetype)modelWithMainRow:(NSInteger)mainRow subRow:(NSInteger)subRow;
@end
