//
//  Status.m
//  微博MQ
//
//  Created by qingyun on 16/1/4.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "Status.h"
#import "Common.h"
#import "User.h"

@implementation Status

-(instancetype)initStatusWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        self.created_at = dictionary[kStatusCreateTime];
        
        // NSdate 转换成NSString
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        //定义一个转换的标准
        NSString *dateFormatterString = @"EEE MMM dd HH:mm:ss zzz yyyy";
        formatter.dateFormat = dateFormatterString;
        //我们处在的时区
//        NSLocale *usLocale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_us"];//这个是例子，不知道是那个国家的时区
        NSLocale *usLocale = [NSLocale currentLocale];
        formatter.locale = usLocale;
        self.created_at = [formatter dateFromString:dictionary[kStatusCreateTime]];
        
        self.statusId = dictionary[kStatusID];
        self.text = dictionary[kStatusText];
//        self.source = dictionary[kStatusSource];
        self.source = [self sourceWithString:dictionary[kStatusSource]];
        NSDictionary *userinfo = dictionary[kStatusUserInfo];
        self.user = [[User alloc]initUserWithDictionary:userinfo];
        NSDictionary *re_status = dictionary[kStatusRetweetStatus];
        
        if (re_status) {
            self.retweeted_status = [[Status alloc]initStatusWithDictionary:re_status];
        }
        self.reposts_count = dictionary[kStatusRepostsCount];
        self.attitudes_count = dictionary[kStatusAttitudesCount];
        self.comments_count = dictionary[kStatusCommentsCount];
    }
    return self;
}


-(NSString *)timeAgo
{
    //动态的计算出属性的值
    //计算出当前时间和create_at的时间差，然后再返回对应的显示方式
    NSTimeInterval interval = [[NSDate date]timeIntervalSinceDate:self.created_at];
    //这个时间差单位是秒 s
    if (interval < 60) {
        return @"刚刚";
    }else if (interval < 3600){
        
        return [NSString stringWithFormat:@"% ld分钟前",(NSInteger)interval/60];
        
    }else if (interval < 60 * 60 *24){
        
        return [NSString stringWithFormat:@"%ld 小时前",(NSInteger)interval/(60 * 60)];
        
    }else if (interval < 60 *60 *24 *30){
        
        return [NSString stringWithFormat:@"%ld 天前",(NSInteger)interval / (60 *60 *24)];
        
    }else{
        return [NSDateFormatter localizedStringFromDate:self.created_at dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    }
    return _timeAgo;
}

-(NSString *)sourceWithString:(NSString *)string{
    //排除无效的字符串
    if ([string isKindOfClass:[NSNull class]] || [string isEqualToString:@""] || !string ) {
        return nil;
    }
    //正则表达式的条件
    NSString *regStr = @">.*<";
    NSError *error;
    //初始化一个正则表达式的对象
    NSRegularExpression *expressoin = [NSRegularExpression regularExpressionWithPattern:regStr options:0 error:&error];
    //用正则表达式取字符串中查找满足条件的结果
    NSTextCheckingResult *result = [expressoin firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
    if (result) {
        //根据结果取出满足条件的子字符串
        NSRange range = result.range;
        NSString *source = [string substringWithRange:NSMakeRange(range.location +1, range.length -2)];
        //追加字符串
        source = [@"来自"stringByAppendingString:source];
        return source;
    }
    return nil;
}

@end
