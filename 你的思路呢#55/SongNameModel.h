//
//  SongNameModel.h
//  你的思路呢#55
//
//  Created by qingyun on 15/12/25.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongNameModel : NSObject

@property(nonatomic, strong)NSString *kName;
@property(nonatomic, strong)NSString *kType;

-(instancetype)initWithDic:(NSDictionary *)dic;

+(instancetype)modeWithDic:(NSDictionary *)dic;

@end
