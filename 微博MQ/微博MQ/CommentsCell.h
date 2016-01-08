//
//  CommentsCell.h
//  微博MQ
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Comment,Status;
@interface CommentsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *textStr;


-(void)bangingComments:(Comment *)comment;

-(void)bandingStatus:(Status *)status;


@end
