//
//  XQModel.h
//  房产展示
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQModel : NSObject
@property(nonatomic, strong)NSString *toward;//朝向
@property(nonatomic, strong)NSString *config;//布置（几室几厅）
@property(nonatomic, strong)NSString *com;//小区
@property(nonatomic, strong)NSString *education;//教育环境
@property(nonatomic, strong)NSString *entertainment;//休闲娱乐
@property(nonatomic, strong)NSString *business;//周边商圈
@property(nonatomic, strong)NSString *iconurl;//经纪人头像
@property(nonatomic, strong)NSArray *image;//室内照片
@property(nonatomic, strong)NSNumber *mob;//联系电话
@property(nonatomic, strong)NSString *lng;//经度
@property(nonatomic, strong)NSString *person;//个人/中介
@property(nonatomic, strong)NSString *name;//姓名
@property(nonatomic, strong)NSString *environmental;//周边环境
@property(nonatomic, strong)NSString *type;//房屋用途
@property(nonatomic, strong)NSString *state;//整租/合租
@property(nonatomic, strong)NSString *cid;//小区编号
@property(nonatomic, strong)NSString *facility;//交通状况
@property(nonatomic, strong)NSNumber *area;//面积
@property(nonatomic, strong)NSString *lat;//纬度
@property(nonatomic, strong)NSString *fitment;//装修程度
@property(nonatomic, strong)NSString *desc;//详细描述
@property(nonatomic, strong)NSString *address;//地址
@property(nonatomic, strong)NSNumber *floor;//楼层


-(instancetype)initWithDictionary:(NSDictionary *)dict;

+(instancetype)modelWithDictionary:(NSDictionary *)dict;


@end
