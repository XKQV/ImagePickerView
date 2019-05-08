//
//  ISUFCollectionViewCell.m
//  ImagePicker
//
//  Created by 董志玮 on 2019/5/6.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "ISUserFeedbackCollectionViewCell.h"

@implementation ISUserFeedbackCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //imageview
        CGRect imageViewFrame = self.frame;
        imageViewFrame.origin = CGPointMake(0, 0);
        self.topImageView  = [[UIImageView alloc] initWithFrame:imageViewFrame];
        self.topImageView.clipsToBounds = YES;
        self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.topImageView];
        
        //delete button
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        float deleteButtonWidth = self.frame.size.width * 0.22;
        self.deleteButton.frame = CGRectMake(self.frame.size.width - deleteButtonWidth, 0, deleteButtonWidth, deleteButtonWidth);
        self.deleteButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.deleteButton.bounds      byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopRight    cornerRadii:CGSizeMake(4, 4)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.deleteButton.bounds;
        maskLayer.path = maskPath.CGPath;
        self.deleteButton.layer.mask = maskLayer;
        
        [self.deleteButton setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
        [self.deleteButton addTarget:self action:@selector(didDeleteClick) forControlEvents:UIControlEventTouchUpInside];
        self.deleteButton.alpha = 0.5;
        
    }
    
    return self;
}

- (void)didDeleteClick {
    
    [self.delegate pressedDeleteButtonTag:(int)self.deleteButton.tag];
}
@end
