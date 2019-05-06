//
//  ISUFImagePickerManager.m
//  ImagePicker
//
//  Created by 董志玮 on 2019/5/5.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "ISUFImagePickerManager.h"


@implementation ISUFImagePickerManager
-(UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.imageArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2", nil];
        layout.itemSize = CGSizeMake(100, 100);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 20;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor greenColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ISUFCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        [_collectionView reloadData];
    }
    return _collectionView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ISUFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.topImage.image = [UIImage imageNamed:@"2"];
    cell.topImage.backgroundColor = [UIColor yellowColor];
    cell.backgroundColor = [UIColor redColor];
    cell.botlabel.backgroundColor = [UIColor grayColor];
    cell.deleteBtn.tag = indexPath.row;
    
    if (indexPath.row == _imageArray.count) {
        cell.topImage.image = [UIImage imageNamed:@"plus"];
        [cell.deleteBtn removeFromSuperview];
        
    }else{
        cell.botlabel.text = _imageArray[indexPath.row];
        [cell.contentView addSubview:cell.deleteBtn];
    }
    
    return cell;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count + 1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == _imageArray.count) {
        [_imageArray addObject:@"3"];
            [self setupActionsheet];
        [collectionView reloadData];
    }
}

-(void)pressedDeleteBtTag:(int)tag{
    
    NSLog(@"deleted cell %d",tag);
    [_imageArray removeObjectAtIndex:tag];
    [_collectionView reloadData];

}

-(void)setupActionsheet{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *pop = [alertController popoverPresentationController];
        pop.permittedArrowDirections = UIPopoverArrowDirectionAny;
        pop.sourceView = self.collectionView;
        pop.sourceRect = self.collectionView.bounds;
    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self goCameraViewController];
                    NSLog(@"goCameraViewController");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self directGoPhotoViewController];
                    NSLog(@"directGoPhotoViewController");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
