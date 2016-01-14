//
//  XQTableViewCell2.m
//  房产展示
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "XQTableViewCell2.h"
#import "UIImageView+WebCache.h"
#import "common.h"

@implementation XQTableViewCell2

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setZFmodel:(ZFModel *)ZFmodel
{
    _ZFmodel = ZFmodel;
    _price.text = [NSString stringWithFormat:@"价格：%d元/月",[ZFmodel.price intValue]];
    _rType.text = [NSString stringWithFormat:@"户型： %@",ZFmodel.housetype];
}

//-(void)setupXQmodel:(XQModel *)XQmodel
-(void)setXQmodel:(XQModel *)XQmodel
{
    _XQmodel = XQmodel;
    _title.text = [NSString stringWithFormat:@"%@",XQmodel.desc];
    _floor.text = [NSString stringWithFormat:@"楼层:     %d",[XQmodel.floor intValue]];
    _area.text  = [NSString stringWithFormat:@"面积： %d㎡",[XQmodel.area intValue]];
    _toward.text = [NSString stringWithFormat:@"朝向：%@",XQmodel.toward];
    _fitment.text = [NSString stringWithFormat:@"装修：%@",XQmodel.fitment];
    _year.text = [NSString stringWithFormat:@"年代：%@",XQmodel.config ];
    _com.text = [NSString stringWithFormat:@"小区：%@",XQmodel.com];
    _address.text = [NSString stringWithFormat:@"地址：%@",XQmodel.address];
    _desc.text = [NSString stringWithFormat:@"描述：%@",XQmodel.desc];
    _business.text = [NSString stringWithFormat:@"周边商圈：%@",XQmodel.business];
    _education.text = [NSString stringWithFormat:@"周边学校：%@",XQmodel.education];
    _entertainment.text = [NSString stringWithFormat:@"休闲娱乐：%@",XQmodel.entertainment];
    _environmental.text = [NSString stringWithFormat:@"周边环境：%@",XQmodel.environmental];
    _facility.text = [NSString stringWithFormat:@"交通情况：%@",XQmodel.facility];
    _name.text = [NSString stringWithFormat:@"姓名：%@",XQmodel.name];
    _mob.text = [NSString stringWithFormat:@"电话：%d",[XQmodel.mob intValue]];
    
    //判断 如果图片的url信息不是空的，不是什么都没有， 不是不存在。那么就显示
    if (![XQmodel.iconurl isKindOfClass:[NSNull class]] || ![XQmodel.iconurl isEqualToString:@""] || !XQmodel.iconurl) {
        NSString *URLstr = [ImageUrl stringByAppendingPathComponent:XQmodel.iconurl];
        
        [self.ZJImageView sd_setImageWithURL:[NSURL URLWithString:URLstr]];
    }
}

@end
