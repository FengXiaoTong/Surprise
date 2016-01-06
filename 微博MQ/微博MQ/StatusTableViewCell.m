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
#import "UIImageView+WebCache.h"

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
    CGFloat imageHeight = [StatusTableViewCell  imageSuperHeightWith:info.pic_urls];
    
    //再加上上下高度的约束，就是cell的总高度
    return size.height + imageHeight +62+1+1;
    
    
    
}

// 方法，在图片下面加一层试图，作为父试图，从而好进行自动布局约束,算出高度
+(CGFloat)imageSuperHeightWith:(NSArray *)pic_urls{
    NSInteger count = pic_urls.count;
    if (count == 0) {//如果没图片
        return 0;//返回图片高度为0！
    }
    if (count > 9) {//微博最多是九宫格，表面最多显示9张图片！
        count = 9;
    }
    NSInteger line = (count-1)/3  + 1;//计算出（需要）行数，程序员都是从0开始数的！
    CGFloat height = line * kImageHeight +(line -1) * kImageMarge;
    return height;
}



//绑定参数
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
    //布局微博图片
    [self layoutImage:info.pic_urls forView:self.imagesView];
    
}


-(void)layoutImage:(NSArray *)images forView:(UIView *)view
{
    //清空父试图（view）上面的子试图
    NSArray *subView = view.subviews;
    [subView makeObjectsPerformSelector:@selector(removeFromSuperview)];//make方法意思是数组中的每一个对象都执行@selector方法！
    
    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //取出图片
        NSString *urlString = obj[@"thumbnail_pic"];
        //初始化imageView
        UIImageView *imageView = [[UIImageView alloc]init];
        //计算出每张图片所在的行数和列数
        CGFloat imageX = idx%3 * (kImageWidth + kImageMarge);
        CGFloat imageY = idx/3 *(kImageHeight + kImageMarge);
        imageView.frame = CGRectMake(imageX, imageY, kImageWidth, kImageHeight);
        [view addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    }];
}

@end
