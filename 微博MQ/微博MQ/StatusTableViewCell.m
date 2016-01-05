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
#import "Status.h"
#import "User.h"

#define kImageWidth  90 //定义图片的宽
#define kImageHeight 90 //定义图片的高
#define kImageMarge  5  //图片之间的间隔

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


+(CGFloat)heightWithStatus:(Status *)info
{
    //计算出文字显示需要的高度
    NSString *text = info.text;
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17] With:kAppSCreenBounds.size.width - 16];
    
    //计算出图片显示需要的高度
    CGFloat imageHeight = [StatusTableViewCell imageSuperHeightWith:info.pic_urls];
    
    //再加上上下高度的约束，就是cell的总高度
    return size.height +imageHeight +62+1+1;
    
    
    
}


+(CGFloat)imageSuperHeightWith:(NSArray *)pic_urls{
    NSInteger count = pic_urls.count;
    if (count == 0) {
        return 0;
    }
    if (count > 9) {
        count = 9;
    }
    NSInteger line = (count-1)/3  + 1;//计算出行数
    CGFloat height = line * kImageHeight +(line -1) * kImageMarge;
    return height;
}

-(void)bandingStatus:(Status *)info
{
//    NSDictionary *use = info[@"user"];
//    NSString *urlString = use[@"profile_image_url"];
    
    NSString *urlString = info.user.profile_image_url;
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
    
    
    self.names.text = info.user.name;
    self.times.text = info.timeAgo;
    self.sources.text = info.source;
    self.contents.text = info.text;
    
}

@end
