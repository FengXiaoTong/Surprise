//
//  XQTableViewCell1.m
//  房产展示
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "XQTableViewCell1.h"

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
    
    
    _xqScrollView = newScrollView;
}


@end
