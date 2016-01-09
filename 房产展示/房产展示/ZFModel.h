//
//  ZFModel.h
//  房产展示
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFModel : NSObject

@property(nonatomic, strong)NSString *camera;
@property(nonatomic, strong)NSString *iconurl;
@property(nonatomic, strong)NSString *temprownumber;
@property(nonatomic, strong)NSString *price;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *nid;
@property(nonatomic, strong)NSString *community;
@property(nonatomic, strong)NSString *simpleadd;
@property(nonatomic, strong)NSString *housetype;
@property(nonatomic, strong)NSString *cid;



-(instancetype)initWithDictionary:(NSDictionary *)dict;

+(instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
