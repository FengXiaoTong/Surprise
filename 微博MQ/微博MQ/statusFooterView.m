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


//根据索引，设置按钮的选中状态
-(void)selected:(NSInteger)index
{
    switch (index) {
        case 1:
        {
            [self.retwitterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.comment setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.likeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.leftConstraint.constant = self.retwitterBtn.center.x - 5;//移动指示方块到选中的View下面
        }
            break;
            
        case 2:
        {
            [self.retwitterBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.comment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.likeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.leftConstraint.constant = self.comment.center.x -5;
        }
            break;
            
        case 3:
        {
            [self.retwitterBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.comment setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.leftConstraint.constant = self.
            likeBtn.center.x - 5;//减去小方块的一半
        }
            break;
            
        default:
            break;
    }
    
}

@end
