//
//  UITableView+index.m
//  微博MQ
//
//  Created by qingyun on 15/12/29.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "UITableView+index.h"

@implementation UITableView (index)

-(NSInteger)initWithIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    for (int i=0; i<indexPath.section; i++) {
        
        index += [self numberOfRowsInSection:i];
    }
    
    return index;
}

@end
