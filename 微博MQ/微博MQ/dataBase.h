//
//  dataBase.h
//  微博MQ
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataBase : NSObject

+(void)saveStatus:(NSArray *)statuses;

+(NSArray *)getStatusFromDB;

@end
