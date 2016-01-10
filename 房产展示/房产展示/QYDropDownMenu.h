//
//  QYDropDownMenu.h
//  DropDownMenu1508
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QYDropDownMenuDelegate <NSObject>

-(void)didSelectedMenuMainTableViewRow:(NSInteger)mainRow subTableView:(NSInteger)subRow;

@end

typedef NS_ENUM(NSInteger, QYDropDownMenuType) {
    QYDropDownMenuTypeSingleColumn,//单列
    QYDropDownMenuTypeDoubleColumnSingleSelection,//双列，单选
    QYDropDownMenuTypeDoubleColumnMutSelection//双列，多选
};

@interface QYDropDownMenu : UIView
@property (nonatomic, strong) NSArray *datas;//所有数据
@property (nonatomic) QYDropDownMenuType menuType;//类型
@property (nonatomic, assign)id <QYDropDownMenuDelegate> delegate;

@property (nonatomic, strong)NSArray *selectedRows;//已经选中的行
@end
