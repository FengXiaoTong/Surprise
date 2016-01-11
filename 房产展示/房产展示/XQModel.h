//
//  XQModel.h
//  房产展示
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQModel : NSObject
@property(nonatomic, strong)NSString *toward;
@property(nonatomic, strong)NSString *config;
@property(nonatomic, strong)NSString *com;
@property(nonatomic, strong)NSString *education;
@property(nonatomic, strong)NSString *entertainment;
@property(nonatomic, strong)NSString *business;
@property(nonatomic, strong)NSString *iconurl;
@property(nonatomic, strong)NSString *image;
@property(nonatomic, strong)NSString *mob;
@property(nonatomic, strong)NSString *lng;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *environmental;
@property(nonatomic, strong)NSString *type;
@property(nonatomic, strong)NSString *state;
@property(nonatomic, strong)NSString *cid;
@property(nonatomic, strong)NSString *facility;
@property(nonatomic, strong)NSString *area;
@property(nonatomic, strong)NSString *lat;
@property(nonatomic, strong)NSString *fitment;
@property(nonatomic, strong)NSString *desc;
@property(nonatomic, strong)NSString *address;
@property(nonatomic, strong)NSString *floor;


-(instancetype)initWithDictionary:(NSDictionary *)dict;

+(instancetype)modelWithDictionary:(NSDictionary *)dict;


@end
