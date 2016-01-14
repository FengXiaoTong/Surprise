//
//  XQTableViewCell1.h
//  房产展示
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "XQModel.h"
#import "UIImageView+WebCache.h"
#import "ZFModel.h"

@interface XQTableViewCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *xqScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *xqImageView;
@property (weak, nonatomic) IBOutlet UIPageControl *xqPageControl;

@property (nonatomic, strong)XQModel *XQmodel;
@property (nonatomic, strong)ZFModel *ZFmodel;
@end
