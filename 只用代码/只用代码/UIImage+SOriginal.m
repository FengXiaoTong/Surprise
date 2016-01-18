//
//  UIImage+SOriginal.m
//  只用代码
//
//  Created by qingyun on 16/1/18.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "UIImage+SOriginal.h"

@implementation UIImage (SOriginal)
//instancetype会默认识别当前是哪个类或者对象调用，就会转换成对应的类的对象
//加载最原始的图片，不被渲染的图片
+(instancetype)imageWithOriginalName:(NSString *)imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    return  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

@end
