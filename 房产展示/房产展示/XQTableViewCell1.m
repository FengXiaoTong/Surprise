//
//  XQTableViewCell1.m
//  房产展示
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "XQTableViewCell1.h"

@interface XQTableViewCell1 ()<UIScrollViewDelegate>

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

    self.xqScrollView.delegate = self;
  
    for (int i = 0; i < imageCount; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(375 * i, 0, 375, 150)];
        NSString *urlStr = [ImageUrl stringByAppendingPathComponent:XQmodel.image[i]];
        [imgView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        [self.xqScrollView addSubview:imgView];
        [self.xqScrollView
         setContentOffset:CGPointMake(375 *i, 0) animated:YES];
    }
    
}

-(void)setXqPageControl:(UIPageControl *)xqPageControl
{
    _xqPageControl.numberOfPages = _XQmodel.image.count;
    //设置pageControl的圆点颜色
    _xqPageControl.pageIndicatorTintColor = [UIColor redColor];
    _xqPageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    
    [_xqPageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)pageControlClick:(UIPageControl *)pageControl
{
   
    _xqScrollView.contentOffset = CGPointMake(375 * pageControl.currentPage, 0);
}


@end
