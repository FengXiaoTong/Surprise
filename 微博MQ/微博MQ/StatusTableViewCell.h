//
//  StatusTableViewCell.h
//  微博MQ
//
//  Created by qingyun on 15/12/30.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Status;
@interface StatusTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icons;
@property (weak, nonatomic) IBOutlet UILabel *names;

@property (weak, nonatomic) IBOutlet UILabel *times;

@property (weak, nonatomic) IBOutlet UILabel *sources;

@property (weak, nonatomic) IBOutlet UILabel *contents;

-(void)bandingStatus:(Status *)info;

+(CGFloat)heightWithStatus:(Status *)info;

@end
