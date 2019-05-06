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
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _topImage.clipsToBounds = YES;
        _topImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_topImage];
        
        _botlabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 80, 50,20)];
        [self.contentView addSubview:_botlabel];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         _deleteBtn.frame = CGRectMake(80, 0, 20, 20);
        _deleteBtn.backgroundColor = [UIColor redColor];
        _deleteBtn.titleLabel.text = @"111";
        [_deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(didDeleteClick) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.alpha = 0.5;
//        [self.contentView addSubview:_deleteBtn];
        
    }
    
    return self;
}

- (void)didDeleteClick {
    
    [self.delegate pressedDeleteBtTag:(int)self.deleteBtn.tag];
}
@end
