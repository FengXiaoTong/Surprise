//
//  XQTableViewCell1.m
//  房产展示
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "XQTableViewCell1.h"
#import "common.h"
#import "XQModel.h"
#import "UIImageView+WebCache.h"


@interface XQTableViewCell1 ()

@property (nonatomic, strong)XQModel *XQmodel;

@end

@implementation XQTableViewCell1

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


//重写scrollView的set方法
-(void)setXqScrollView:(UIScrollView *)xqScrollView
{
        UIScrollView *newScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 375, 150)];
        newScrollView.pagingEnabled = YES;
        NSArray *AllImg = _XQmodel.image; //获取图片数组
        NSUInteger imageCount = AllImg.count; //获取图片数量
        //scrollerView里面的View的宽度即contentSize
        newScrollView.contentSize = CGSizeMake(375 * imageCount, 150);
        
        _xqScrollView = newScrollView;
  

}

-(void)setXQmodel:(XQModel *)XQmodel
{
    _XQmodel = XQmodel;
    

}


-(void)setXqImageView:(UIImageView *)xqImageView
{
    NSArray *AllImg = _XQmodel.image; //获取图片数组
    NSUInteger imageCount = AllImg.count;
    for (int i = 0; i < imageCount; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i * 375, 0, 375, 150)];
        NSString *urlStr = [ImageUrl stringByAppendingPathComponent:self.XQmodel.image[i]];
        [_xqImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        [self.xqImageView addSubview:imgView];
    }
    return;
   
}


@end
