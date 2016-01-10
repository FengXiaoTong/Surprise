//
//  QYTableViewCell.m
//  DropDownMenu1508
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import "QYTableViewCell.h"
#import "QYMainModel.h"
#import "QYSubModel.h"
@implementation QYTableViewCell

//主表
-(void)setMainModel:(QYMainModel *)mainModel{
    _mainModel = mainModel;
    if (mainModel.isSelected) {
        self.textLabel.textColor = [UIColor blueColor];
    }else{
        self.textLabel.textColor = [UIColor blackColor];
    }
    self.textLabel.text = mainModel.area;
}
//从表
-(void)setSubModel:(QYSubModel *)subModel{
    _subModel = subModel;
    if (subModel.isSelected) {
        self.textLabel.textColor = [UIColor blueColor];
    }else{
        self.textLabel.textColor = [UIColor blackColor];
    }
    self.textLabel.text = subModel.title;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
