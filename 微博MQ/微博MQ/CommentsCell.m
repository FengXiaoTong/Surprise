//
//  CommentsCell.m
//  微博MQ
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "CommentsCell.h"
#import "UIImageView+WebCache.h"
#import "User.h"
#import "Comment.h"
#import "Common.h"
#import "Status.h"


@implementation CommentsCell

- (void)awakeFromNib {
    //设置lable预计显示的最大宽度
    self.textStr.preferredMaxLayoutWidth = kAppSCreenBounds.size.width -8-8-8-50;
}


-(void)bangingComments:(Comment *)comment
{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image_url]];
    self.name.text = comment.user.name;
    self.textStr.text = comment.commentText;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bandingStatus:(Status *)status{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url]];
    self.name.text = status.user.name;
    self.textStr.text = status.text;
}


@end
