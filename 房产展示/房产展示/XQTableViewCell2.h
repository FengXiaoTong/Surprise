//
//  XQTableViewCell2.h
//  房产展示
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFModel.h"
#import "XQModel.h"

@interface XQTableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;//标题
@property (weak, nonatomic) IBOutlet UILabel *price;//价钱
@property (weak, nonatomic) IBOutlet UILabel *floor;//楼层
@property (weak, nonatomic) IBOutlet UILabel *rType;//房型
@property (weak, nonatomic) IBOutlet UILabel *area;//面积
@property (weak, nonatomic) IBOutlet UILabel *toward;//朝向
@property (weak, nonatomic) IBOutlet UILabel *fitment;//装修
@property (weak, nonatomic) IBOutlet UILabel *year;//年代
@property (weak, nonatomic) IBOutlet UILabel *com;//小区
@property (weak, nonatomic) IBOutlet UILabel *address;//地址
@property (weak, nonatomic) IBOutlet UILabel *desc;//详细描述
@property (weak, nonatomic) IBOutlet UILabel *business;//商业百货
@property (weak, nonatomic) IBOutlet UILabel *education;//学校教育
@property (weak, nonatomic) IBOutlet UILabel *entertainment;//休闲娱乐
@property (weak, nonatomic) IBOutlet UILabel *environmental;//周围环境
@property (weak, nonatomic) IBOutlet UILabel *facility;//交通状况
@property (weak, nonatomic) IBOutlet UILabel *name;//名字
@property (weak, nonatomic) IBOutlet UILabel *mob;//电话
@property (weak, nonatomic) IBOutlet UIImageView *ZJImageView;
@property (weak, nonatomic) IBOutlet UIButton *callButton;

@property (nonatomic, strong)ZFModel *ZFmodel;  
@property (nonatomic, strong)XQModel *XQmodel;
//-(void)setupXQmodel:(XQModel *)XQmodel;




@end
