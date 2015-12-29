//
//  NSString+filePath.m
//  微博MQ
//
//  Created by qingyun on 15/12/29.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "NSString+filePath.h"

@implementation NSString (filePath)

+(NSString *)filePathInDocumentsWithFileName:(NSString *)fileName
{
    //通过归档，保存登录model
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

@end
