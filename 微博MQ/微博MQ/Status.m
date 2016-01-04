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
        self.statusId = dictionary[kStatusID];
        self.text = dictionary[kStatusText];
        self.source = dictionary[kStatusSource];
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

@end
