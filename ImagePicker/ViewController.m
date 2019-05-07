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
@property (nonatomic, strong) UIScrollView *imageScrollView;
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

-(void)showActionsheet{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *pop = [alertController popoverPresentationController];
        pop.permittedArrowDirections = UIPopoverArrowDirectionAny;
        pop.sourceView = self.view;
        pop.sourceRect = self.view.bounds;
    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"保存到手机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //        [self goCameraViewController];
        NSLog(@"saveToPhone");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteImage];
        NSLog(@"deleteImage");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)deleteImage{
    int index = _imageScrollView.contentOffset.x / _imageScrollView.frame.size.width;
    NSLog(@"index is at %d", index);
    
}

-(void)presentDetailedScrollImageView:(UIScrollView *)imageScrollView {
    self.imageScrollView = imageScrollView;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    ISUFDetailedImageViewController *imageScrollVC = [[ISUFDetailedImageViewController alloc]init];
    imageScrollVC.navigationController = self.navigationController;
    
    imageScrollVC.view.frame  = self.view.bounds;
    [imageScrollVC.view addSubview:_imageScrollView];
    
    
    
    //tap gesture to hide unhide navbar 
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideNavBar)];
    [_imageScrollView addGestureRecognizer:tapGesture];
    //view bounces when using the below code
    //    self.navigationController.hidesBarsOnTap = YES;
    
    //fix the black bar issue, when the navbar is set to hidden
    CGPoint scrollViewOffset = _imageScrollView.contentOffset;
    scrollViewOffset.y = 64;
    [_imageScrollView setContentOffset:scrollViewOffset animated:YES];
    CGSize svContentSize = _imageScrollView.contentSize;
    svContentSize.height -= 64;
    imageScrollView.contentSize = svContentSize;
    
    //right button
    imageScrollVC.navigationController.navigationBar.topItem.title = @"hi";
    UIBarButtonItem *choiceBt = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActionsheet)];
    
    imageScrollVC.navigationItem.rightBarButtonItem = choiceBt;
    imageScrollVC.navigationItem.title = @"1";
//    imageScrollVC.navigationController.navigationItem.rightBarButtonItem = choiceBt;
    [self.navigationController pushViewController:imageScrollVC animated:YES];
//
//    self.navigationController.topViewController.navigationItem.rightBarButtonItem = choiceBt;
    
}


-(void)hideNavBar{
    if (!self.navigationController){
        return;
    }
    
    if (self.navigationController.isNavigationBarHidden) {
        //appear
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

//-(void)currentImages{
//    for (UIImage *image in _manager.imageArray) {
//        NSLog(@"images");
//    }
//
//}

@end
