//
//  statusFooterView.h
//  微博MQ
//
//  Created by qingyun on 16/1/7.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;
@interface statusFooterView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIButton *retwitterBtn;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIView *selectedView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

-(void)bangingStatus:(Status *)status;

-(void)selected:(NSInteger)index;

@end
