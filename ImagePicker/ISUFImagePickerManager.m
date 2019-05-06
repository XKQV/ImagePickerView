//
//  ISUFImagePickerManager.m
//  ImagePicker
//
//  Created by 董志玮 on 2019/5/5.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "ISUFImagePickerManager.h"


@implementation ISUFImagePickerManager

#pragma mark -- collection view
-(UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        self.imageArray = [[NSMutableArray alloc]init];
        layout.itemSize = CGSizeMake(100, 100);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 20;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 120) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ISUFCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        _collectionView.scrollEnabled = false;
        
    }
    return _collectionView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ISUFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.deleteBtn.tag = indexPath.row;
    
    if (indexPath.row == _imageArray.count) {
        cell.topImage.image = [UIImage imageNamed:@"plus"];
        [cell.deleteBtn removeFromSuperview];
        
    }else{
        //        cell.botlabel.text = _imageArray[indexPath.row];
        cell.topImage.image = _imageArray[indexPath.row];
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
        [self setupActionsheet];
    }
}
#pragma mark -- Actions
-(void)pressedDeleteBtTag:(int)tag{
    
    NSLog(@"deleted cell %d",tag);
    [_imageArray removeObjectAtIndex:tag];
    [self updateCollectionViewHeight];
    [_collectionView reloadData];
    
}
-(void)updateCollectionViewHeight{
    CGRect frame = _collectionView.frame;
    if (_imageArray.count < 3) {
        frame.size.height = 120;
        _collectionView.frame = frame;
    }else if(_imageArray.count < 6){
        frame.size.height = 240;
        _collectionView.frame = frame;
    }else if (_imageArray.count <= 9){
        frame.size.height = 360;
        _collectionView.frame = frame;
    }
    
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
                [self goCameraViewController];
        NSLog(@"goCameraViewController");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self directGoPhotoViewController];
        NSLog(@"directGoPhotoViewController");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)okAlertControllerWithMessage:(NSString*)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Information" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -- Camera
-(void)goCameraViewController{
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        return;
    }
    
        //创建ImagePickController
        UIImagePickerController *myPicker = [[UIImagePickerController alloc]init];
    
        //创建源类型
        UIImagePickerControllerSourceType mySourceType = UIImagePickerControllerSourceTypeCamera ;
    
        myPicker.sourceType = mySourceType;
    
        //设置代理
        myPicker.delegate = self;
        //设置可编辑
        //    myPicker.allowsEditing = YES;
    
        //通过模态的方式推出系统相册
        [self presentViewController:myPicker animated:YES completion:^{
            NSLog(@"进入相册");
        }];
    
}


#pragma mark -- Photo library
-(void)directGoPhotoViewController{
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        return;
    }
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        return;
    }
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        return;
    }
    
    //    //创建ImagePickController
    //    UIImagePickerController *myPicker = [[UIImagePickerController alloc]init];
    //
    //    //创建源类型
    //    UIImagePickerControllerSourceType mySourceType = UIImagePickerControllerSourceTypePhotoLibrary ;
    //
    //    myPicker.sourceType = mySourceType;
    //
    //    //设置代理
    //    myPicker.delegate = self;
    //    //设置可编辑
    //    //    myPicker.allowsEditing = YES;
    //
    //    //通过模态的方式推出系统相册
    //    [self presentViewController:myPicker animated:YES completion:^{
    //        NSLog(@"进入相册");
    //    }];
    
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.maximumNumberOfSelection = 9;
    imagePickerController.showsNumberOfSelectedAssets = YES;
    
    [self presentViewController:imagePickerController animated:YES completion:NULL];
}
#pragma mark -- 实现imagePicker的代理方法
-(void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    for (PHAsset *asset in assets) {
        // Do something with the asset
        __weak typeof (self) weakSelf = self;
        [asset requestContentEditingInputWithOptions:[PHContentEditingInputRequestOptions new] completionHandler:^(PHContentEditingInput *contentEditingInput, NSDictionary *info) {
            
            NSURL *imageURL = contentEditingInput.fullSizeImageURL;
            if (imageURL) {
                NSData *data = [NSData dataWithContentsOfURL:imageURL];
                UIImage *img = [[UIImage alloc] initWithData:data];
                if (weakSelf.imageArray.count < 9) {
                    [weakSelf.imageArray addObject:img];
                    [self updateCollectionViewHeight];
                    [weakSelf.collectionView reloadData];
                }else {
                    [self performSelectorOnMainThread:@selector(okAlertControllerWithMessage:) withObject:@"Please select no more than 9 images" waitUntilDone:YES];
                }
                
            }else {
                [self performSelectorOnMainThread:@selector(okAlertControllerWithMessage:) withObject:@"Please only select images" waitUntilDone:YES];
            }
            
        }];
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //取得所选取的图片,原大小,可编辑等，info是选取的图片的信息字典
    UIImage *selectImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //设置图片进相框
    [_imageArray addObject:selectImage];
    [self updateCollectionViewHeight];
    [_collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"模态返回") ;
        
    }];
}

@end
