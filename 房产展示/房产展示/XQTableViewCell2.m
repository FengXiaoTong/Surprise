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
    _title.text = XQmodel.desc;
   // _price.text = self.ZFmodel.price;
//    NSString *str = [NSString stringWithFormat:@"%@",XQmodel.floor];
//   _floor.text = str;
    _rType.text = self.ZFmodel.housetype;
//    _area.text  = XQmodel.area;
    _toward.text = XQmodel.toward;
    _fitment.text = XQmodel.fitment;
//    _year.text = XQmodel.config;
    _com.text = XQmodel.com;
    _address.text = XQmodel.address;
    _desc.text = XQmodel.desc;
    _business.text = XQmodel.business;
    _education.text = XQmodel.education;
    _entertainment.text = XQmodel.entertainment;
    _environmental.text = XQmodel.environmental;
    _facility.text = XQmodel.facility;
    _name.text = XQmodel.name;
//    _mob.text = XQmodel.mob;
    
}

@end
