//
//  ISUFCollectionViewCell.h
//  ImagePicker
//
//  Created by 董志玮 on 2019/5/6.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ISUserFeedbackCellDelegate <NSObject>

-(void)pressedDeleteButtonTag:(int)tag;

@end
@interface ISUserFeedbackCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *topImage;

@property (strong, nonatomic) UILabel *botlabel;

@property (strong, nonatomic) UIButton *deleteButton;

@property (weak, nonatomic) id<ISUserFeedbackCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
