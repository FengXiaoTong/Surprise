//
//  StatusTableViewCell.m
//  微博MQ
//
//  Created by qingyun on 15/12/30.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "StatusTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Common.h"
#import "NSString+StringSize.h"

@implementation StatusTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //label预计显示的最大宽度
    self.contents.preferredMaxLayoutWidth = kAppSCreenBounds.size.width -20;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(CGFloat)heightWithStatus:(NSDictionary *)info
{
    //计算出文字显示需要的高度
    NSString *text = info[@"text"];
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17] With:kAppSCreenBounds.size.width - 16];
    
    //再加上上下高度的约束，就是cell的总高度
    return size.height +62+1+1;
    
}

-(void)bandingStatus:(NSDictionary *)info
{
    NSDictionary *use = info[@"user"];
    NSString *urlString = use[@"profile_image_url"];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    self.icons.image = [UIImage imageWithData:data];
//
//    //
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            self.icon.image = [UIImage imageWithData:data];
//        });
//    });
    
    [self.icons sd_setImageWithURL:[NSURL URLWithString:urlString]];
    self.icons.layer.cornerRadius = self.icons.bounds.size.width / 2;
    self.icons.layer.masksToBounds = YES;
    
    
    self.names.text = use[@"name"];
    self.times.text = info[@"created_at"];
    self.sources.text = info[@"source"];
    self.contents.text = info[@"text"];
    
}

@end
