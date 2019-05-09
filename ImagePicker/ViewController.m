//
//  ViewController.m
//  ImagePicker
//
//  Created by 董志玮 on 2019/4/30.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<viewDidChangeHeightDelegate>
@property (nonatomic, strong) ISUserFeedbackImagePickerManagerView *manager;
@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (nonatomic, strong) UIButton *imageBt2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //assistant button
    UIButton *imageBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 50)];
    [imageBt addTarget:self action:@selector(currentImages) forControlEvents:UIControlEventTouchUpInside];
    imageBt.backgroundColor = [UIColor greenColor];
    [imageBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [imageBt setTitle:@"Question" forState:UIControlStateNormal];
    [self.view addSubview:imageBt];
    
    //init the view
    self.manager = [[ISUserFeedbackImagePickerManagerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageBt.frame) + 20, [UIScreen mainScreen].bounds.size.width, 120) cellEdge:10.0 labelTitle:@"图片问题（选填）" labelFrame:CGRectMake(0, CGRectGetMaxY(imageBt.frame), 200, 20) labelFont:[UIFont systemFontOfSize:16] maxNumberOfImages:6];

    self.manager.delegate = self;
    
    //assistant button
    [self.view addSubview:_manager];
    self.imageBt2 = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_manager.frame), 100, 50)];
    [self.imageBt2 addTarget:self action:@selector(currentImages) forControlEvents:UIControlEventTouchUpInside];
    self.imageBt2.backgroundColor = [UIColor greenColor];
    [self.imageBt2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.imageBt2 setTitle:@"Email" forState:UIControlStateNormal];
    [self.view addSubview:self.imageBt2];

   
    
}
- (void)viewviewDidChangeHeight {
     self.imageBt2.frame = CGRectMake(0, CGRectGetMaxY(_manager.frame), 100, 50);
}




-(void)currentImages{
    for (UIImage *image in _manager.imageArray) {
        NSLog(@"images");
    }

}

@end
