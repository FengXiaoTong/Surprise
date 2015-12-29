//
//  Account.m
//  微博MQ
//
//  Created by qingyun on 15/12/29.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//
//{
//    "access_token": "ACCESS_TOKEN",
//    "expires_in": 1234,
//    "remind_in":"798114",
//    "uid":"12341234"
//}

#import "Account.h"
#import "Common.h"
#import "NSString+filePath.h"

@interface Account ()<NSCoding>

@property (nonatomic, strong)NSString * accessToken;
@property (nonatomic, strong)NSDate *expiresIn;
@property (nonatomic, strong)NSString *uid;


@end

@implementation Account


+(instancetype)currentAccount
{
    static Account *account;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        NSString *filePah = [NSString filePathInDocumentsWithFileName:kAccountFileName];
        account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePah];
        if (!account) {
           account = [[Account alloc]init];
        }
    
    });
    return account;
}


-(void)saveLogin:(NSDictionary *)dic
{
    self.accessToken = dic[access_token];
    NSNumber *number = dic[expires_in];
    //当前时间 加上生命周期 ，就等于失效时间
    self.expiresIn = [[NSDate date] dateByAddingTimeInterval:number.integerValue];
    
    self.uid = dic[userId];
   
    [NSKeyedArchiver archiveRootObject:self toFile:[NSString filePathInDocumentsWithFileName:kAccountFileName]];
    
}


-(BOOL)isLogin
{
    if (self.accessToken && [[NSDate date]compare:self.expiresIn] < 0) {
        return YES;
    }
    return NO;
}

-(void)logout
{
    self.accessToken = nil;
    self.uid = nil;
    self.expiresIn = nil;  //这三个是清理内存中的
    
    //这是清理物理文件里的
    NSString *strPath = [NSString filePathInDocumentsWithFileName:kAccountFileName];
    [[NSFileManager defaultManager]removeItemAtPath:strPath error:nil];
}

#pragma mark --归档解档
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.accessToken forKey:access_token];
    [aCoder encodeObject:self.expiresIn forKey:expires_in];
    [aCoder encodeObject:self.uid forKey:userId];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.accessToken = [aDecoder decodeObjectForKey:access_token];
        self.expiresIn = [aDecoder decodeObjectForKey:expires_in];
        self.uid = [aDecoder decodeObjectForKey:userId];
    }
    return self;
}

@end
