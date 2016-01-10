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

#define imageUrl @"http://www.fungpu.com/houseapp/"

@interface ZFTableViewCell ()



@end

@implementation ZFTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setZfModel:(ZFModel *)zfModel
{
    _zfModel = zfModel;
    
//    _iconurl.image = [UIImage imageNamed:zfModel.iconurl];
    _title.text = zfModel.title;
    _housetype.text = zfModel.housetype;
    _community.text = zfModel.community;
    _simpleadd.text = zfModel.simpleadd;
        _price.text = [NSString stringWithFormat:@"%@/月",zfModel.price];//等价于下面的两句，都是讲请求的数据转化为string类型，然后赋值使用！

//    NSString *price = [NSString stringWithFormat:@"%@/月",zfModel.price];
//    _price.text = price;
    
    NSString *picURlStr = [imageUrl stringByAppendingPathComponent:zfModel.iconurl];

    [self.iconurl sd_setImageWithURL:[NSURL URLWithString:picURlStr]];//第三方异步加载图片！
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
