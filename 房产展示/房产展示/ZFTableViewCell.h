//
//  ZFTableViewCell.h
//  房产展示
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFModel.h"

@interface ZFTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconurl;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *community;

@property (weak, nonatomic) IBOutlet UILabel *simpleadd;

@property (weak, nonatomic) IBOutlet UILabel *housetype;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (nonatomic, strong)ZFModel *zfModel;

@end
