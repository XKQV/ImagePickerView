//
//  ISUFImagePickerManager.h
//  ImagePicker
//
//  Created by 董志玮 on 2019/5/5.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ISUFCollectionViewCell.h"
#import <QBImagePickerController/QBImagePickerController.h>
NS_ASSUME_NONNULL_BEGIN

@interface ISUFImagePickerManager : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ISUFCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIImagePickerControllerDelegate,QBImagePickerControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) CGRect collectionViewFrame;

@end

NS_ASSUME_NONNULL_END
