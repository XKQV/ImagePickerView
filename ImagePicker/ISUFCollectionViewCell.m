//
//  ISUFCollectionViewCell.m
//  ImagePicker
//
//  Created by 董志玮 on 2019/5/6.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "ISUFCollectionViewCell.h"

@implementation ISUFCollectionViewCell
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
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         _deleteBtn.frame = CGRectMake(80, 0, 20, 20);
        _deleteBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_deleteBtn.bounds      byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopRight    cornerRadii:CGSizeMake(4, 4)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _deleteBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        _deleteBtn.layer.mask = maskLayer;

        [_deleteBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(didDeleteClick) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.alpha = 0.5;
        
    }
    
    return self;
}

- (void)didDeleteClick {
    
    [self.delegate pressedDeleteBtTag:(int)self.deleteBtn.tag];
}
@end
