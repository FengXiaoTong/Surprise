//
//  QYDropDownMenu.m
//  DropDownMenu1508
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 hnqingyun. All rights reserved.
//

#import "QYDropDownMenu.h"
#import "QYMainModel.h"
#import "QYSubModel.h"
#import "QYTableViewCell.h"
#import "QYSelectedMenuModel.h"
@interface QYDropDownMenu ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;//主表
@property (nonatomic, strong) UITableView *subTableView;//从表

@property (nonatomic) NSInteger mainTableViewSelectedRow;//当前选中的主表的行
@end

@implementation QYDropDownMenu

-(void)setSelectedRows:(NSArray *)selectedRows{
    _selectedRows = selectedRows;
    
    //根据selectedRows来设置mainTableViewSelectedRow
    _mainTableViewSelectedRow = [selectedRows.firstObject mainRow];
    
    //把datas中的isSelected全部置为no
    [self setNoForModelIsSelected];
    //根据selectedRows中的数据来更改datas的isSelected为yes
    for (QYSelectedMenuModel *selectedModel in selectedRows) {
        NSInteger mainSelectedRow = selectedModel.mainRow;
        NSInteger subSelectedRow = selectedModel.subRow;
        
        [self setYesForMainModelIsSelected:mainSelectedRow subModelIsSelected:subSelectedRow];
    }
    //刷新主从表
    [_mainTableView reloadData];
    [_subTableView reloadData];
}

-(void)setYesForMainModelIsSelected:(NSInteger)mainSelectedRow subModelIsSelected:(NSInteger)subSelectedRow{
    //主表model
    QYMainModel *mainModel = _datas[mainSelectedRow];
    mainModel.isSelected = YES;
    //从表model
    if (self.menuType != QYDropDownMenuTypeSingleColumn) {
        QYSubModel *subModel = mainModel.listarea[subSelectedRow];
        subModel.isSelected = YES;
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //主表
        UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 2.0, frame.size.height) style:UITableViewStylePlain];
        [self addSubview:mainTableView];
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        [mainTableView registerClass:[QYTableViewCell class] forCellReuseIdentifier:@"cell"];
        _mainTableView = mainTableView;
        
        //从表
        UITableView *subTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width / 2.0, 0, frame.size.width / 2.0, frame.size.height) style:UITableViewStylePlain];
        [self addSubview:subTableView];
        subTableView.delegate = self;
        subTableView.dataSource = self;
        [subTableView registerClass:[QYTableViewCell class] forCellReuseIdentifier:@"cell"];
        _subTableView = subTableView;
        
    }
    return self;
}

#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _mainTableView) {
        return _datas.count;
    }else{
        QYMainModel *mainModel = _datas[_mainTableViewSelectedRow];
        return mainModel.listarea.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (tableView == _mainTableView) {
        QYMainModel *mainModel = _datas[indexPath.row];
        cell.mainModel = mainModel;
    }else{
        QYMainModel *mainModel = _datas[_mainTableViewSelectedRow];
        QYSubModel *subModel = mainModel.listarea[indexPath.row];
        cell.subModel = subModel;
    }
    
    return cell;
}

//点击单元格
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.menuType) {
        case QYDropDownMenuTypeSingleColumn:
            [self singleTableView:tableView didSelectedRowAtIndexPath:indexPath];
            break;
        case QYDropDownMenuTypeDoubleColumnSingleSelection:
            [self singleSelectionDoubleTableView:tableView didSelectedRowAtIndexPath:indexPath];
            break;
        case QYDropDownMenuTypeDoubleColumnMutSelection:
            [self mutSelectionDoubleTableView:tableView didSelectedRowAtIndexPath:indexPath];
            break;
            
        default:
            break;
    }
}

//单表，单选
-(void)singleTableView:(UITableView *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置主表所有模型的isSelected为no
    [self setNoForMainModelIsSelected];
    //把选中的行对应的模型的isSelected为yes
    QYMainModel *mainModel = _datas[indexPath.row];
    mainModel.isSelected = YES;
    //刷新表格
    [_mainTableView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(didSelectedMenuMainTableViewRow:subTableView:)]) {
        [self.delegate  didSelectedMenuMainTableViewRow:indexPath.row subTableView:-1];
    }
}

//设置主表所有模型的isSelected为no
-(void)setNoForMainModelIsSelected{
    for (QYMainModel *mainModel in _datas) {
        mainModel.isSelected = NO;
    }
}
//双表，单选
-(void)singleSelectionDoubleTableView:(UITableView *)tableView  didSelectedRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _mainTableView) {//主表
        //把主表所有模型中的isSelected置为no
        [self setNoForMainModelIsSelected];
        //把选中的行对应的模型的isSelected置为yes
        QYMainModel *mainModel = _datas[indexPath.row];
        mainModel.isSelected = YES;
        //把主表选中的行保存
        _mainTableViewSelectedRow = indexPath.row;
        //刷新主表（更改主表中的字体颜色）
        [_mainTableView reloadData];
        //刷新从表（显示主表选中行对应的从表数据）
        [_subTableView reloadData];
    }else{//从表
        //把主从表中所有的模型的isSelected置为no
        [self setNoForModelIsSelected];
        //设置主表中当前选中的行的isSelected置为yes
        QYMainModel *mainModel = _datas[_mainTableViewSelectedRow];
        mainModel.isSelected = YES;
        //设置从表中当前选中的行的isSelected置为yes
        QYSubModel *subModel = mainModel.listarea[indexPath.row];
        subModel.isSelected = YES;
        //刷新从表
        [_subTableView reloadData];
        
        if ([self.delegate respondsToSelector:@selector(didSelectedMenuMainTableViewRow:subTableView:)]) {
            [self.delegate  didSelectedMenuMainTableViewRow:_mainTableViewSelectedRow subTableView:indexPath.row];
        }
    }
}

//把主从表中所有的模型的isSelected置为no
-(void)setNoForModelIsSelected{
    for (QYMainModel *mainModel in _datas) {
        mainModel.isSelected = NO;
        for (QYSubModel *subModel in mainModel.listarea) {
            subModel.isSelected = NO;
        }
    }
}

//双表，多选
-(void)mutSelectionDoubleTableView:(UITableView *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _mainTableView) {//主表
        //根据从表中是否有选中行，来决定其对应的主表行的isSelected
        [self setValueForMainModelIsSelectedWithSubModeIsSelected];
        //更改当前选中的主表行的isSelected为yes
        QYMainModel *mainModel = _datas[indexPath.row];
        mainModel.isSelected = YES;
        //把当前选中的主表的行保存
        _mainTableViewSelectedRow = indexPath.row;
        //刷新主从表
        [_mainTableView reloadData];
        [_subTableView reloadData];
        
    }else{//从表
        //把当前选中的主表行对应子表的所有模型的isSelected置为no
        [self setNoForSubModelIsSelected:_mainTableViewSelectedRow];
        //把当前选的子表行对应的模型的isSelected置为yes
        QYMainModel *mainModel = _datas[_mainTableViewSelectedRow];
        QYSubModel *subModel = mainModel.listarea[indexPath.row];
        subModel.isSelected = YES;
        //刷新子表
        [_subTableView reloadData];
        if ([self.delegate respondsToSelector:@selector(didSelectedMenuMainTableViewRow:subTableView:)]) {
            [self.delegate  didSelectedMenuMainTableViewRow:_mainTableViewSelectedRow subTableView:indexPath.row];
        }
    }
}
//把当前选中的主表行对应子表的所有模型的isSelected置为no
-(void)setNoForSubModelIsSelected:(NSInteger)mainSelectedIndex{
    QYMainModel *mainModel = _datas[mainSelectedIndex];
    for (QYSubModel *subModel in mainModel.listarea) {
        subModel.isSelected = NO;
    }
}

//根据从表中是否有选中行，来决定其对应的主表行的isSelected
-(void)setValueForMainModelIsSelectedWithSubModeIsSelected{
    for (QYMainModel *mainModel in _datas) {
        BOOL selected = NO;
        for (QYSubModel *subModel in mainModel.listarea) {
            if (subModel.isSelected) {
                selected = YES;
                break;
            }
        }
        if (selected) {
            mainModel.isSelected = YES;
        }else{
            mainModel.isSelected = NO;
        }
    }
}

@end
