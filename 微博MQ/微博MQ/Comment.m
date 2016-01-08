//
//  Comment.m
//  微博MQ
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "Comment.h"
#import "User.h"

@implementation Comment


-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        // NSdate 转换成NSString
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        //定义一个转换的标准
        NSString *dateFormatterString = @"EEE MMM dd HH:mm:ss zzz yyyy";
        formatter.dateFormat = dateFormatterString;
        //我们处在的时区
        //        NSLocale *usLocale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_us"];//这个是例子，不知道是那个国家的时区
        NSLocale *usLocale = [NSLocale currentLocale];
        formatter.locale = usLocale;
        self.created_at = [formatter dateFromString:dic[@"created_at"]];
        self.commentId = dic[@"id"];
        self.text = dic[@"text"];
        self.user = [[User alloc]initUserWithDictionary:dic[@"user"]];
        
        NSDictionary *recomment = dic[@"reply_comment"];
        if (recomment) {
            self.reply_comment = [[Comment alloc]initWithDictionary:recomment];
        }
        
    }
    return self;
}

@end
