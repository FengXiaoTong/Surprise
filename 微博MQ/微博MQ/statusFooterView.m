//
//  statusFooterView.m
//  微博MQ
//
//  Created by qingyun on 16/1/7.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "statusFooterView.h"
#import "Status.h"

@implementation statusFooterView


-(void)awakeFromNib{
    
    self.backgroundView = [[UIView alloc]init];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
}


-(void)bangingStatus:(Status *)status
{
    NSNumber *retwitterCount = status.reposts_count;//转发微博的数量
//    self.retwitterBtn.titleLabel.text = retwitterCount.stringValue;
    
    [self.retwitterBtn setTitle:retwitterCount.stringValue forState:UIControlStateNormal];
    [self.comment setTitle:status.comments_count.stringValue forState:UIControlStateNormal];
    [self.likeBtn setTitle:status.attitudes_count.stringValue forState:UIControlStateNormal];
    
}

@end
