//
//  NSString+StringSize.m
//  微博MQ
//
//  Created by qingyun on 16/1/4.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "NSString+StringSize.h"

@implementation NSString (StringSize)


-(CGSize)sizeWithFont:(UIFont *)font With:(CGFloat)width
{
    CGSize size = CGSizeMake(width, MAXFLOAT);//限制文字显示的区域
    NSDictionary *dit = @{NSFontAttributeName: font};//文字显示字体的属性
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dit context:nil];//计算出文字需要的大小
    return rect.size;
}

@end
