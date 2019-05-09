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
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) int maxImages;
@property (nonatomic, assign) float cellItemWidth;
@property (nonatomic, assign) float cellEdge;
@end

@implementation ISUserFeedbackImagePickerManagerView

#pragma mark -- collection view
- (instancetype)initWithFrame:(CGRect)collectionViewFrame cellEdge:(float)edge labelTitle:(NSString *)title labelFrame:(CGRect)labelFrame labelFont:(UIFont *)font maxNumberOfImages:(int)maxNumberOfImages {
    self = [super init];
    if (self) {
        //Setup main view parameters
        CGRect viewFrame = labelFrame;
        viewFrame.size.height += collectionViewFrame.size.height;
        viewFrame.size.width = collectionViewFrame.size.width;
        
        //Main View that contains a label and a collection view
        self = [[ISUserFeedbackImagePickerManagerView alloc]initWithFrame:viewFrame];
        self.backgroundColor = [UIColor whiteColor];
        self.collectionViewInitialFrame = collectionViewFrame;
        self.imageArray = [[NSMutableArray alloc]init];
        self.maxImages = maxNumberOfImages;
        self.cellEdge = edge;
        
        //Label
        self.titleLabelFrame = labelFrame;
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(self.cellEdge, 0, labelFrame.size.width, labelFrame.size.height)];
        titlelabel.text = title;
        titlelabel.font = font;
        
        //Collection view Layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.cellItemWidth = (collectionViewFrame.size.width - edge * 2 - 40) / 3;
        layout.itemSize = CGSizeMake(self.cellItemWidth, self.cellItemWidth);
        layout.sectionInset = UIEdgeInsetsMake(self.cellEdge, self.cellEdge, self.cellEdge, self.cellEdge);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 15;
        
        //Collection view
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, labelFrame.size.height, collectionViewFrame.size.width, collectionViewFrame.size.height + self.cellEdge) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.collectionView registerClass:[ISUserFeedbackCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        self.collectionView.scrollEnabled = false;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        [self addSubview:titlelabel];
        [self addSubview:self.collectionView];
    }
    
    return self;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ISUserFeedbackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (!self.imageArray) {
        return cell;
    }
    
    cell.delegate = self;
    cell.deleteButton.tag = indexPath.row;
    
    if (indexPath.row < self.imageArray.count) {
        cell.topImageView.image = self.imageArray[indexPath.row];
        [cell.contentView addSubview:cell.deleteButton];
    }else{
        cell.topImageView.image = [UIImage imageNamed:@"plus"];
        [cell.deleteButton removeFromSuperview];
    }
    return cell;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (!self.imageArray) {
        return 0;
    }
    if (self.imageArray.count < self.maxImages) {
        return self.imageArray.count + 1;
    } else {
        return self.imageArray.count;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.imageArray.count) {
        [self showActionsheet];
    }
    
}
#pragma mark -- Actions
- (void)pressedDeleteButtonTag:(int)tag {
    
    [self.imageArray removeObjectAtIndex:tag];
    [self updateCollectionViewHeight];
    [self.collectionView reloadData];
    
}
- (void)updateCollectionViewHeight {
    if (!self.collectionView) {
        return;
    }
    CGRect mainviewFrame = self.frame;
    CGRect collectionViewframe = self.collectionView.frame;
    if (_imageArray.count < 3 || self.maxImages <= 3) {
        collectionViewframe.size.height = self.cellEdge * 2 + self.cellItemWidth;
        self.collectionView.frame = collectionViewframe;
        
        mainviewFrame.size.height = _titleLabelFrame.size.height + collectionViewframe.size.height;
        self.frame = mainviewFrame;
        
    }else if(_imageArray.count < 6 || self.maxImages <= 6 ){
        collectionViewframe.size.height = self.cellEdge * 3 + self.cellItemWidth * 2;
        self.collectionView.frame = collectionViewframe;
        
        mainviewFrame.size.height = _titleLabelFrame.size.height + collectionViewframe.size.height;
        self.frame = mainviewFrame;
        
    }else if (_imageArray.count <= self.maxImages){
        collectionViewframe.size.height = self.cellEdge * 4 + self.cellItemWidth * 3;
        self.collectionView.frame = collectionViewframe;
        
        mainviewFrame.size.height = _titleLabelFrame.size.height + collectionViewframe.size.height;
        self.frame = mainviewFrame;
    }
    
    [self.delegate viewviewDidChangeHeight];
    
}
-(void)layoutSubviews{
    
}

- (void)showActionsheet {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *pop = [alertController popoverPresentationController];
        pop.permittedArrowDirections = UIPopoverArrowDirectionAny;
        pop.sourceView = self.collectionView;
        pop.sourceRect = self.collectionView.bounds;
    }
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cardbase2.3_48", @"拍照") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goCameraViewController];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cardbase2.3_49", @"从相册选择") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self directToPhotoViewController];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"取消") style:UIAlertActionStyleCancel handler:nil]];
    
    [self showViewControllerOnTheCurrentView:alertController];
}

- (void)showViewControllerOnTheCurrentView:(UIViewController *)viewController {
    
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

- (void)dismissViewControllerOnTheCurrentView {
    
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

- (void)okAlertControllerWithMessage:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Information" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    
    [self showViewControllerOnTheCurrentView:alert];
}

#pragma mark -- Camera
- (void)goCameraViewController {
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        return;
    }
    //ImagePickController
    UIImagePickerController *cameraImagePicker = [[UIImagePickerController alloc]init];
    UIImagePickerControllerSourceType mySourceType = UIImagePickerControllerSourceTypeCamera ;
    
    cameraImagePicker.sourceType = mySourceType;
    cameraImagePicker.delegate = self;
    //    myPicker.allowsEditing = YES;
    [self showViewControllerOnTheCurrentView:cameraImagePicker];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *selectImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageArray addObject:selectImage];
    [self updateCollectionViewHeight];
    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- Photo library
- (void)directToPhotoViewController {
    
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
    imagePickerController.maximumNumberOfSelection = self.maxImages;
    imagePickerController.showsNumberOfSelectedAssets = YES;
    
    [self showViewControllerOnTheCurrentView:imagePickerController];
    
}

#pragma mark -- 实现imagePicker的代理方法
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    for (PHAsset *asset in assets) {
        // Do something with the asset
        __weak typeof (self) weakSelf = self;
        [asset requestContentEditingInputWithOptions:[PHContentEditingInputRequestOptions new] completionHandler:^(PHContentEditingInput *contentEditingInput, NSDictionary *info) {
            
            NSURL *imageURL = contentEditingInput.fullSizeImageURL;
            if (imageURL) {
                NSData *data = [NSData dataWithContentsOfURL:imageURL];
                UIImage *img = [[UIImage alloc] initWithData:data];
                if (weakSelf.imageArray.count < self.maxImages) {
                    [weakSelf.imageArray addObject:img];
                    [self updateCollectionViewHeight];
                    [weakSelf.collectionView reloadData];
                    
                }else {
                    [self performSelectorOnMainThread:@selector(okAlertControllerWithMessage:) withObject:[NSString stringWithFormat:@"Please select no more than %d images", self.maxImages] waitUntilDone:YES];
                }
            }else {
                [self performSelectorOnMainThread:@selector(okAlertControllerWithMessage:) withObject:@"Please only select images" waitUntilDone:YES];
            }
            
            
            
        }];
    }
    
    [self dismissViewControllerOnTheCurrentView];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    
    [self dismissViewControllerOnTheCurrentView];
}



@end
