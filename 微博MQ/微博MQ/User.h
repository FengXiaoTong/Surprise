//
//  User.h
//  微博MQ
//
//  Created by qingyun on 16/1/4.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject


@property (nonatomic,strong)NSString *userId;//id	int64	用户UID
@property (nonatomic,strong)NSString *name;//name	string	友好显示名称

@property (nonatomic,strong)NSString *userDescription;//description	string	用户个人描述
@property (nonatomic,strong)NSString *profile_image_url;//profile_image_url	string	用户头像地址（中图），50×50像素
@property (nonatomic,strong)NSString *avatar_large;//avatar_large	string	用户头像地址（大图），180×180像素
@property (nonatomic, strong)NSString *verified_reason;//verified_reason	string	认证原因


-(instancetype)initUserWithDictionary:(NSDictionary *)dictionary;


@end
