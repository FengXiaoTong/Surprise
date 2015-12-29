//
//  Account.h
//  微博MQ
//
//  Created by qingyun on 15/12/29.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

//单例的类方法
+(instancetype)currentAccount;

//单例提供的保存方法
-(void)saveLogin:(NSDictionary *)dic;

-(BOOL)isLogin;

//清楚登录信息（令牌失效，或者时间失效）
-(void)logout;

@end
