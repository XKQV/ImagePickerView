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
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _topImage.clipsToBounds = YES;
        _topImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_topImage];
        
        //label not used 
        _botlabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 80, 50,20)];
//        [self.contentView addSubview:_botlabel];
        
        self.layer.cornerRadius = 4.0;
        [self.layer setMasksToBounds:YES];
        
        
        //delete button
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
         _deleteButton.frame = CGRectMake(80, 0, 20, 20);
        _deleteButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_deleteButton.bounds      byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopRight    cornerRadii:CGSizeMake(4, 4)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _deleteButton.bounds;
        maskLayer.path = maskPath.CGPath;
        _deleteButton.layer.mask = maskLayer;

        [_deleteButton setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(didDeleteClick) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.alpha = 0.5;
        
    }
    
    return self;
}

- (void)didDeleteClick {
    
    [self.delegate pressedDeleteButtonTag:(int)self.deleteButton.tag];
}
@end
