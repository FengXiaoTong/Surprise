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
    
    //代码布局collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//横着翻页 默认是竖着翻页，所以不设置也罢！
    layout.headerReferenceSize = CGSizeMake(30, 30);
    layout.sectionInset = UIEdgeInsetsMake(5, 15, 20, 25);
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.footerReferenceSize = CGSizeMake(30, 30);
    
    self.collPicView.collectionViewLayout = layout;
    self.collPicView.delegate = self;
    self.collPicView.dataSource = self;
    self.collPicView.pagingEnabled = YES;
    //section的多选
    self.collPicView.allowsMultipleSelection = NO;
    
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


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row %2 == 0) {
        return CGSizeMake(200, 200);
    }
    return CGSizeMake(100, 100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
