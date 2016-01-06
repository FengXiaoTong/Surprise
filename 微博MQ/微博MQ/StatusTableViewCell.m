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
#import "SDPhotoBrowser.h"

#define kImageWidth  90 //定义图片的宽
#define kImageHeight 90 //定义图片的高
#define kImageMarge  5  //图片之间的间隔
@interface StatusTableViewCell ()<SDPhotoBrowserDelegate>

@end

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
    
    Status *reStatus = info.retweeted_status;
    if (reStatus) {
        //加上转发微博需要的高度
        CGSize reStitterSize = [reStatus.text sizeWithFont:[UIFont systemFontOfSize:17] With:kAppSCreenBounds.size.width - 20];
        //计算出图片显示需要的高度
        CGFloat imageHeight = [StatusTableViewCell  imageSuperHeightWith:reStatus.pic_urls];
        
        //再加上上下高度的约束，就是cell的总高度
        return size.height + reStitterSize.height + imageHeight +62+1;
    }else{
        //没有转发微博的时候，加上正文图片的高度
        //计算出图片显示需要的高度
        CGFloat imageHeight = [StatusTableViewCell  imageSuperHeightWith:info.pic_urls];
        return size.height + imageHeight + 62 +1 +1 ;
    }

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
    Status *retweeted = info.retweeted_status; //转发微博
    if (retweeted) {
        //清空微博配图
        [self layoutImage:nil forView:self.imagesView HeightContients:self.ImageSuperHeiCon];
        self.rewrittrer.text = retweeted.text;
        [self layoutImage:retweeted.pic_urls forView:self.rewritterSuperView HeightContients:self.reImageSuperHeightConstraint];
        
    }else{
        //布局微博图片
        [self layoutImage:info.pic_urls forView:self.imagesView HeightContients:self.ImageSuperHeiCon];
        self.rewrittrer.text = nil;
        [self layoutImage:nil forView:self.rewritterSuperView HeightContients:self.reImageSuperHeightConstraint];
    }
    
}


-(void)layoutImage:(NSArray *)images forView:(UIView *)view HeightContients:(NSLayoutConstraint *)heightConstraint
{
    //清空父试图（view）上面的子试图
    NSArray *subView = view.subviews;
    [subView makeObjectsPerformSelector:@selector(removeFromSuperview)];//make方法意思是数组中的每一个对象都执行@selector方法！
    
    
    //将view调整到合适的高度
    CGFloat height = [StatusTableViewCell imageSuperHeightWith:images];
    heightConstraint.constant = height;//修改的是高度上的高度
    
    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //取出图片
        NSString *urlString = obj[@"thumbnail_pic"];
        //初始化imageView
        UIImageView *imageView = [[UIImageView alloc]init];
        //计算出每张图片所在的行数和列数
        CGFloat imageX = idx%3 * (kImageWidth + kImageMarge);
        CGFloat imageY = idx/3 *(kImageHeight + kImageMarge);
        imageView.frame = CGRectMake(imageX, imageY, kImageWidth, kImageHeight);
        
        imageView.userInteractionEnabled = YES;
        //添加响应
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageShow:)];
        [imageView addGestureRecognizer:tap];
        imageView.tag = idx;
        
        [view addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    }];
}

-(void)imageShow:(UITapGestureRecognizer *)gesture{
    
    UIView *view = gesture.view;
    NSLog(@"view.tag:%ld",view.tag);
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc]init];
    browser.sourceImagesContainerView = view.superview;
    browser.imageCount = view.superview.subviews.count;
    browser.currentImageIndex = (int)view.tag;
    browser.delegate =self;
    [browser show];
    
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    //返回的是原图--占位图（缩略图）
    UIView *spView = self.imagesView.subviews.count != 0 ?self.imagesView : self.rewritterSuperView;
    UIImageView *imgView = spView.subviews[index];
    return imgView.image;
}


- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    //返回的是高质量图片的url
    UIView *spView = self.imagesView.subviews.count != 0 ?self.imagesView : self.rewritterSuperView;
    UIImageView *imgView = spView.subviews[index];
    //找到图片绑定的url
    NSString *urlStr = imgView.sd_imageURL.absoluteString;
    //组合大图的url ，大图和缩略图的url只有参数改变了一点，替换下即可
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
    return [NSURL URLWithString:urlStr];
}



@end
