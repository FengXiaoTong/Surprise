//
//  StatusTableViewCell.m
//  微博MQ
//
//  Created by qingyun on 15/12/30.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "StatusTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation StatusTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:urlString]];
    self.names.text = use[@"name"];
    self.times.text = info[@"created_at"];
    self.sources.text = info[@"source"];
    self.contents.text = info[@"text"];
    
}

@end
