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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.manager = [[ISUserFeedbackImagePickerManagerView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 120) cellSize:CGSizeMake(100, 100)  labelTitle:@"图片问题（选填）" labelFrame:CGRectMake(0, 80, 200, 20) labelFont:[UIFont systemFontOfSize:16]];
    
    //    self.manager.delegate = self;
    
    
    [self.view addSubview:_manager];
    
//        UIButton *imageBt = [[UIButton alloc]initWithFrame:CGRectMake(200, 300, 100, 100)];
//        [imageBt addTarget:self action:@selector(currentImages) forControlEvents:UIControlEventTouchUpInside];
//        imageBt.backgroundColor = [UIColor greenColor];
//        [self.view addSubview:imageBt];
    
}


//
//-(void)currentImages{
//    for (UIImage *image in _manager.imageArray) {
//        NSLog(@"images");
//    }
//
//}

@end
