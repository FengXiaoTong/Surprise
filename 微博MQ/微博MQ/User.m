//
//  User.m
//  微博MQ
//
//  Created by qingyun on 16/1/4.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "User.h"
#import "Common.h"

@implementation User

-(instancetype)initUserWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        self.userId = dictionary[kUserID];
        self.name = dictionary[kUserInfoName];
        self.userDescription = dictionary[kUserDescription];
        self.profile_image_url = dictionary[kUserProfileImageURL];
        self.avatar_large = dictionary[kUserAvatarLarge];
        self.verified_reason = dictionary[kUserVerifiedReson];
    }
    return self;
}


@end
