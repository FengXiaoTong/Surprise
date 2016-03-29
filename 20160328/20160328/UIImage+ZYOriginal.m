//
//  UIImage+ZYOriginal.m
//  20160328
//
//  Created by runsheng on 16/3/28.
//  Copyright © 2016年 runsheng. All rights reserved.
//

#import "UIImage+ZYOriginal.h"

@implementation UIImage (ZYOriginal)

+(instancetype)imageWithOriginalName:(NSString *)iamgeName
{
    UIImage *image = [UIImage imageNamed:iamgeName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
