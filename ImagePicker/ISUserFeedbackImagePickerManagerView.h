//
//  ISUFImagePickerManager.h
//  ImagePicker
//
//  Created by 董志玮 on 2019/5/5.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ISUserFeedbackCollectionViewCell.h"
#import <QBImagePickerController/QBImagePickerController.h>
NS_ASSUME_NONNULL_BEGIN



@interface ISUserFeedbackImagePickerManagerView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ISUserFeedbackCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIImagePickerControllerDelegate,QBImagePickerControllerDelegate>


//The selected images can be access by this array
@property (nullable, nonatomic, strong) NSMutableArray *imageArray;


/*
 Initiate a UIView with a title label and a collection view under the label.
 Note: The input frame.origin parameter is based on source mainscreen's coordinate system
        The height of the collection view should start with a height that fits for just one row of collection view cell
*/
- (instancetype)initWithFrame:(CGRect)collectionViewFrame cellEdge:(float)edge labelTitle:(NSString *)title labelFrame:(CGRect)labelFrame labelFont:(UIFont *)font maxNumberOfImages:(int)maxNumberOfImages;

@end

NS_ASSUME_NONNULL_END
