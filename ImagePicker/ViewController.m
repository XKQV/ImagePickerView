//
//  ViewController.m
//  ImagePicker
//
//  Created by 董志玮 on 2019/4/30.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (nonatomic, strong) ISUserFeedbackImagePickerManagerView *manager;
@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (nonatomic, strong) UIButton *imageBt2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *imageBt = [[UIButton alloc]initWithFrame:CGRectMake(200, 100, 100, 100)];
    [imageBt addTarget:self action:@selector(currentImages) forControlEvents:UIControlEventTouchUpInside];
    imageBt.backgroundColor = [UIColor greenColor];
    [self.view addSubview:imageBt];
    
    self.manager = [[ISUserFeedbackImagePickerManagerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageBt.frame) + 20, [UIScreen mainScreen].bounds.size.width, 120) cellEdge:10.0 labelTitle:@"图片问题（选填）" labelFrame:CGRectMake(0, CGRectGetMaxY(imageBt.frame), 200, 20) labelFont:[UIFont systemFontOfSize:16] maxNumberOfImages:9];

    [self.view addSubview:_manager];
    self.imageBt2 = [[UIButton alloc]initWithFrame:CGRectMake(200, CGRectGetMaxY(_manager.frame), 100, 100)];
    [self.imageBt2 addTarget:self action:@selector(currentImages) forControlEvents:UIControlEventTouchUpInside];
    self.imageBt2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.imageBt2];

   
    
}

-(void)viewDidLayoutSubviews {
    self.imageBt2.frame = CGRectMake(200, CGRectGetMaxY(_manager.frame), 100, 100);

}

-(void)currentImages{
    for (UIImage *image in _manager.imageArray) {
        NSLog(@"images");
    }

}

@end
