//
//  ViewController.m
//  CollectionView
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "ViewController.h"
#import "ImagesCollectionViewCell.h"
#import "headerView.h"
#import "footView.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.collPicView.delegate = self;
    self.collPicView.dataSource = self;
}



#pragma mark -- collectionViewDataSource/Delegata
//CollectionView里面有多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

//每一组里面有多少元素
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 8;
        }
            break;
            
        case 1:
        {
            return 7;
        }
            break;
            
        case 2:
        {
            return 6;
        }
            break;
            
        default:
            return 0;
            break;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.picImView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.%ld",indexPath.section + 1, indexPath.row + 1]];
    return cell;
}


//headerView和footerView合成一个方法了！！！
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        headerView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        return header;
        
    }else {
        
        footView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        return footer;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
