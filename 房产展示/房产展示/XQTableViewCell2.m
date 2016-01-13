//
//  XQTableViewCell2.m
//  房产展示
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "XQTableViewCell2.h"

@implementation XQTableViewCell2

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//-(void)setupXQmodel:(XQModel *)XQmodel
-(void)setXQmodel:(XQModel *)XQmodel
{
    _XQmodel = XQmodel;
    _title.text = [NSString stringWithFormat:@"%@",XQmodel.desc];
    _price.text = [NSString stringWithFormat:@"价格：%@元/月",self.ZFmodel.price];
//    NSString *str = [NSString stringWithFormat:@"%@",XQmodel.floor];
//   _floor.text = str;
    _rType.text = self.ZFmodel.housetype;
//    _area.text  = XQmodel.area;
    _toward.text = [NSString stringWithFormat:@"朝向：%@",XQmodel.toward];
    _fitment.text = [NSString stringWithFormat:@"装修：%@",XQmodel.fitment];
//    _year.text = XQmodel.config;
    _com.text = [NSString stringWithFormat:@"小区：%@",XQmodel.com];
    _address.text = [NSString stringWithFormat:@"地址：%@",XQmodel.address];
    _desc.text = [NSString stringWithFormat:@"描述：%@",XQmodel.desc];
    _business.text = [NSString stringWithFormat:@"周边商圈：%@",XQmodel.business];
    _education.text = [NSString stringWithFormat:@"周边学校：%@",XQmodel.education];
    _entertainment.text = [NSString stringWithFormat:@"休闲娱乐：%@",XQmodel.entertainment];
    _environmental.text = [NSString stringWithFormat:@"周边环境：%@",XQmodel.environmental];
    _facility.text = [NSString stringWithFormat:@"交通情况：%@",XQmodel.facility];
    _name.text = [NSString stringWithFormat:@"姓名：%@",XQmodel.name];
//    _mob.text = XQmodel.mob;
    
}

@end
