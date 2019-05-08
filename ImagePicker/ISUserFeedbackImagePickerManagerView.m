//
//  ISUFImagePickerManager.m
//  ImagePicker
//
//  Created by 董志玮 on 2019/5/5.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "ISUserFeedbackImagePickerManagerView.h"

@interface ISUserFeedbackImagePickerManagerView()
@property (nonatomic, assign) CGRect titleLabelFrame;
@property (nonatomic, assign) CGRect collectionViewInitialFrame;


@end

@implementation ISUserFeedbackImagePickerManagerView

#pragma mark -- collection view
-(instancetype)initWithFrame:(CGRect)collectionViewFrame CellSize:(CGSize)size labelTitle:(NSString *)title labelFrame:(CGRect)labelFrame labelFont:(UIFont *)font{
    self = [super init];
    if (self) {
        CGRect viewFrame = labelFrame;
        viewFrame.size.height += collectionViewFrame.size.height;
        viewFrame.size.width = collectionViewFrame.size.width;
        float cellEdge = (collectionViewFrame.size.height - size.height) / 2;
        self = [[ISUserFeedbackImagePickerManagerView alloc]initWithFrame:viewFrame];
        self.backgroundColor = [UIColor redColor];
        self.titleLabelFrame = labelFrame;
        self.collectionViewInitialFrame = collectionViewFrame;
        
        //Label
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(cellEdge, 0, labelFrame.size.width, labelFrame.size.height)];
        titlelabel.text = title;
        titlelabel.font = font;
        //Collection view
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        self.imageArray = [[NSMutableArray alloc]init];
        layout.itemSize = size;
        
        layout.sectionInset = UIEdgeInsetsMake(cellEdge, cellEdge, cellEdge, cellEdge);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 15;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, labelFrame.size.height, collectionViewFrame.size.width, collectionViewFrame.size.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor grayColor];
        
        self.collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[ISUFCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        _collectionView.scrollEnabled = false;
        [self addSubview:titlelabel];
        [self addSubview:_collectionView];
    }
    
    return self;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ISUFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.deleteBtn.tag = indexPath.row;
    
    if (indexPath.row == _imageArray.count) {
        cell.topImage.image = [UIImage imageNamed:@"plus"];
        [cell.deleteBtn removeFromSuperview];
    }else{
        cell.topImage.image = _imageArray[indexPath.row];
        [cell.contentView addSubview:cell.deleteBtn];
    }
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (!self.imageArray) {
        return 0;
    }
    if (self.imageArray.count < 9) {
        return self.imageArray.count + 1;
    } else {
        return  self.imageArray.count;
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == _imageArray.count) {
        [self showActionsheet];
    }
    
}
#pragma mark -- Actions
-(void)pressedDeleteBtTag:(int)tag{
    
    NSLog(@"deleted cell %d",tag);
    [_imageArray removeObjectAtIndex:tag];
    [self updateCollectionViewHeight];
    [self.collectionView reloadData];
    
}
-(void)updateCollectionViewHeight{
    if (!self.collectionView) {
        return;
    }
    CGRect mainviewFrame = self.frame;
    CGRect collectionViewframe = self.collectionView.frame;
    if (_imageArray.count < 3) {
        collectionViewframe.size.height = self.collectionViewInitialFrame.size.height;
        self.collectionView.frame = collectionViewframe;
        
        mainviewFrame.size.height = _titleLabelFrame.size.height + collectionViewframe.size.height;
        self.frame = mainviewFrame;
        
    }else if(_imageArray.count < 6){
        collectionViewframe.size.height = self.collectionViewInitialFrame.size.height * 2;
        self.collectionView.frame = collectionViewframe;
        
        mainviewFrame.size.height = _titleLabelFrame.size.height + collectionViewframe.size.height;
        self.frame = mainviewFrame;
        //        [self setNeedsDisplay];
    }else if (_imageArray.count <= 9){
        collectionViewframe.size.height = self.collectionViewInitialFrame.size.height * 3;
        self.collectionView.frame = collectionViewframe;
        
        mainviewFrame.size.height = _titleLabelFrame.size.height + collectionViewframe.size.height;
        self.frame = mainviewFrame;
    }
    
}
-(void)drawRect:(CGRect)rect{
    
}
-(void)showActionsheet{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *pop = [alertController popoverPresentationController];
        pop.permittedArrowDirections = UIPopoverArrowDirectionAny;
        pop.sourceView = self.collectionView;
        pop.sourceRect = self.collectionView.bounds;
    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goCameraViewController];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self directGoPhotoViewController];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self showViewControllerOnTheCurrentView:alertController];
}

- (void)showViewControllerOnTheCurrentView:(UIViewController *)viewController{
    
    id rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if([rootViewController isKindOfClass:[UINavigationController class]])
    {
        rootViewController = ((UINavigationController *)rootViewController).viewControllers.firstObject;
    }
    if([rootViewController isKindOfClass:[UITabBarController class]])
    {
        rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
    }
    [rootViewController presentViewController:viewController animated:YES completion:nil];
}

- (void)dismissViewControllerOnTheCurrentView{
    
    id rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if([rootViewController isKindOfClass:[UINavigationController class]])
    {
        rootViewController = ((UINavigationController *)rootViewController).viewControllers.firstObject;
    }
    if([rootViewController isKindOfClass:[UITabBarController class]])
    {
        rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
    }
    [rootViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)okAlertControllerWithMessage:(NSString*)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Information" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    
    [self dismissViewControllerOnTheCurrentView];
}

#pragma mark -- Camera
-(void)goCameraViewController{
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        return;
    }
    //创建ImagePickController
    UIImagePickerController *cameraImagePicker = [[UIImagePickerController alloc]init];
    
    //创建源类型
    UIImagePickerControllerSourceType mySourceType = UIImagePickerControllerSourceTypeCamera ;
    
    cameraImagePicker.sourceType = mySourceType;
    
    //设置代理
    cameraImagePicker.delegate = self;
    //设置可编辑
    //    myPicker.allowsEditing = YES;
    
    //通过模态的方式推出系统相册
    [self showViewControllerOnTheCurrentView:cameraImagePicker];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *selectImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_imageArray addObject:selectImage];
    [self updateCollectionViewHeight];
    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- Photo library
-(void)directGoPhotoViewController{
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        return;
    }
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        return;
    }
    
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.maximumNumberOfSelection = 9;
    imagePickerController.showsNumberOfSelectedAssets = YES;
    
    [self showViewControllerOnTheCurrentView:imagePickerController];
    
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
    
    [self dismissViewControllerOnTheCurrentView];
}

-(void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    
    //    self
    
    [self dismissViewControllerOnTheCurrentView];
}



@end
