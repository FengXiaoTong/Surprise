//
//  Comment.h
//  微博MQ
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface Comment : NSObject

@property (nonatomic, strong)NSDate *created_at; //created_at	string	评论创建时间
@property (nonatomic, strong)NSNumber *commentId;//id	int64	评论的ID
@property (nonatomic, strong)NSString *text;//text	string	评论的内容
@property (nonatomic, strong)User *user;//user	object	评论作者的用户信息字段 详细
@property (nonatomic,  strong)Comment *reply_comment;//reply_comment	object	评论来源评论，当本评论属于对另一评论的回复时返回此字段

@property (nonatomic) NSString *commentText;


-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
