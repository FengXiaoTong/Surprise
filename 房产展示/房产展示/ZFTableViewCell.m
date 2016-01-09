//
//  ZFTableViewCell.m
//  房产展示
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "ZFTableViewCell.h"
#import "ZFModel.h"
#import "common.h"
#import "UIImageView+WebCache.h"


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
    //    _price.text = [NSString stringWithFormat:@"%@/月",zfModel.price];

    NSString *price = [NSString stringWithFormat:@"%@/月",zfModel.price];
    _price.text = price;
    
    NSString *picURlStr = [QbaseUrl stringByAppendingPathComponent:zfModel.iconurl];
//    UIImage *image = _iconurl.image;
//    [self.imageView.image sd_setImageWithURL:[NSURL URLWithString:picURlStr]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
