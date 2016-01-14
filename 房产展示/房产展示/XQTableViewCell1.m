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
  
//    给xqContentView设置frame
    self.xqContentView.frame = CGRectMake(0, 0, 375 * imageCount, 150);

    self.xqScrollView.contentSize = CGSizeMake(375 * imageCount, 150);//必须设置scrollView的 contentSize 的大小，否则，🐴⚽️的根本滑不动！
//    [self.xqScrollView
//     setContentOffset:CGPointMake(375 , 0) animated:YES];//动画（滑动）
    self.xqScrollView.pagingEnabled = YES;

    self.xqScrollView.delegate = self;
    
    //设置pageControll
    self.xqPageControl.frame = CGRectMake(100,100,175,37);
    _xqPageControl.numberOfPages = imageCount;//原点个数就等于图片数量
    //设置pageControl的圆点颜色
    _xqPageControl.pageIndicatorTintColor = [UIColor redColor];//其余为红色
    _xqPageControl.currentPageIndicatorTintColor = [UIColor greenColor];//当前图片为绿色
      [_xqPageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];//添加点击事件

    for (int i = 0; i < imageCount; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(375 * i, 0, 375, 150)];
        
    if (![XQmodel.image[i] isKindOfClass:[NSNull class]] || ![XQmodel.image[i] isEqualToString:@""] || !XQmodel.image[i]){
        NSString *urlStr = [ImageUrl stringByAppendingPathComponent:XQmodel.image[i]];
        [imgView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        [_xqContentView addSubview:imgView];
//        [self.xqScrollView addSubview:_xqContentView];
            }
        
    }
    
}

//为什么pageControl加不上点击方法呢？pageControl 点击事件可以实现，点击的地方超过一半即可实现
-(void)pageControlClick:(UIPageControl *)pageControl
{
    //根据pageControl的当前页数，可以知道_xqScrollView偏移了多少
    _xqScrollView.contentOffset = CGPointMake(375 * pageControl.currentPage, 0);
}

#pragma mark  -UIScrollViewDelegate

//scrollView已经结束减速（滑动）更改当前页码
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更改pageControl当前页码
    _xqPageControl.currentPage = _xqScrollView.contentOffset.x/375;

}


@end
