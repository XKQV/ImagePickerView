//
//  ViewController.m
//  ImagePicker
//
//  Created by 董志玮 on 2019/4/30.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (nonatomic, strong) ISUFImagePickerManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    _pickerView = [ISSettingImagePickerViewController new];
    //    [self addChildViewController:_pickerView];
    //    _pickerView.view.frame = CGRectMake(0, 100, 0, 0);
    //    _pickerView.view.backgroundColor = [UIColor blueColor];
    //    [self.view addSubview:_pickerView.view];
    //    _pickerView.delegate = self;
    //
    //    _testView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_pickerView.view.frame),100, 100)];
    //    _testView.backgroundColor = [UIColor yellowColor];
    //    [self.view addSubview:_testView];
    //
    //
    _manager = [[ISUFImagePickerManager alloc]init];
    _manager.delegate = self;
    
    [self addChildViewController:_manager];
    [self.view addSubview:_manager.collectionView];
    
    UIButton *imageBt = [[UIButton alloc]initWithFrame:CGRectMake(200, 300, 100, 100)];
    [imageBt addTarget:self action:@selector(currentImages) forControlEvents:UIControlEventTouchUpInside];
    imageBt.backgroundColor = [UIColor greenColor];
    //    [self.view addSubview:imageBt];
    
}

-(void)presentDetailedScrollImageView:(UIScrollView *)imageScrollView {
    
    [self.navigationController.view addSubview:imageScrollView];
    ISUFDetailedImageViewController *imageScrollVC = [[ISUFDetailedImageViewController alloc]init];
    imageScrollVC.view.frame  = self.view.bounds;
    [imageScrollVC.view addSubview:imageScrollView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideNavBar)];
    [imageScrollView addGestureRecognizer:tapGesture];
    
//    self.navigationController.hidesBarsOnTap = YES;
    [self.navigationController pushViewController:imageScrollVC animated:YES];
}


-(void)hideNavBar{
    if (!self.navigationController){
        return;
    }
    if (self.navigationController.isNavigationBarHidden) {
//            [UIApplication sharedApplication].statusBarHidden = NO;
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    }else {
//        [UIApplication sharedApplication].statusBarHidden = YES;
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

-(void)currentImages{
    for (UIImage *image in _manager.imageArray) {
        NSLog(@"images");
    }
    
}

@end
