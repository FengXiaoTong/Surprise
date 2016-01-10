//
//  QYTableViewCell.h
//  DropDownMenu1508
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYMainModel;
@class QYSubModel;
@interface QYTableViewCell : UITableViewCell
@property (nonatomic, strong) QYMainModel *mainModel;//主表数据
@property (nonatomic, strong) QYSubModel *subModel;//从表数据
@end
