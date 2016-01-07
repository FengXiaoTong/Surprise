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

-(void)bangingStatus:(Status *)status;

@end
