//
//  NSString+filePath.h
//  微博MQ
//
//  Created by qingyun on 15/12/29.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (filePath)

//根据文件名，返回文件在Documents下的路径
+(NSString *)filePathInDocumentsWithFileName:(NSString *)fileName;

@end
