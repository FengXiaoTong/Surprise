//
//  geciModel.h
//  你的思路呢#55
//
//  Created by qingyun on 15/12/25.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SongNameModel;
@interface geciModel : NSObject

@property(nonatomic, strong)NSArray *keyArr;
@property(nonatomic, strong)NSMutableDictionary *lrcDic;


+(instancetype)doWithModel:(SongNameModel *)model;

@end
