//
//  ZFTableViewCell.m
//  房产展示
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "ZFTableViewCell.h"
#import "ZFModel.h"
#import "UIImageView+WebCache.h"
#import "common.h"

@implementation ZFTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setZfModel:(ZFModel *)zfModel
{
    _zfModel = zfModel;
    
    _title.text = zfModel.title;
    _housetype.text = zfModel.housetype;
    _community.text = zfModel.community;
    _simpleadd.text = zfModel.simpleadd;
    _price.text = [NSString stringWithFormat:@"%d元/月",[zfModel.price intValue]];//等价于下面的两句，都是讲请求的数据转化为string类型，然后赋值使用！

//    NSString *price = [NSString stringWithFormat:@"%@/月",zfModel.price];
//    _price.text = price;
    
    NSString *picURlStr = [ImageUrl stringByAppendingPathComponent:zfModel.iconurl];

    [self.iconurl sd_setImageWithURL:[NSURL URLWithString:picURlStr]];//第三方库 （异步加载图片）！
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
