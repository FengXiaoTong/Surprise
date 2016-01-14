//
//  XQTableViewCell1.m
//  房产展示
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "XQTableViewCell1.h"

@interface XQTableViewCell1 ()

@end

@implementation XQTableViewCell1

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


-(void)setXQmodel:(XQModel *)XQmodel
{
    _XQmodel = XQmodel;
    NSArray *AllImages = _XQmodel.image;//获取图片数组
    NSUInteger imageCount = AllImages.count;//获取图片数组内容个数
  
    //给xqContentView设置frame
    self.xqContentView.frame = CGRectMake(0, 0, 375 * imageCount, 150);
//    self.xqScrollView.pagingEnabled = YES;
//    self.xqScrollView.contentOffset = CGPointMake(-375, 0);

  
    for (int i = 0; i < imageCount; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(375 * i, 0, 375, 150)];
        NSString *urlStr = [ImageUrl stringByAppendingPathComponent:XQmodel.image[i]];
        [imgView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        [self.xqScrollView addSubview:imgView];
    
    }
}



@end
