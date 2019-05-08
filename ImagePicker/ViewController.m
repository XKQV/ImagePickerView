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
    //    self.manager = [[ISUserFeedbackImagePickerManagerView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 120) andCellSize:CGSizeMake(100, 100)  ];
    self.manager = [[ISUserFeedbackImagePickerManagerView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 120) CellSize:CGSizeMake(100, 100)  labelTitle:@"图片问题（选填）" labelFrame:CGRectMake(0, 80, 200, 20) labelFont:[UIFont systemFontOfSize:16]];
    
    //    self.manager.delegate = self;
    
    
    [self.view addSubview:_manager];
    
    //    UIButton *imageBt = [[UIButton alloc]initWithFrame:CGRectMake(200, 300, 100, 100)];
    //    [imageBt addTarget:self action:@selector(currentImages) forControlEvents:UIControlEventTouchUpInside];
    //    imageBt.backgroundColor = [UIColor greenColor];
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
    [alertController addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteImage];
        NSLog(@"deleteImage");
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"保存到手机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //        [self goCameraViewController];
        NSLog(@"saveToPhone");
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)deleteImage{
    if ( !_manager.imageArray || _manager.imageArray.count == 0 ) {
        return;
    }
    
    int index = _imageScrollView.contentOffset.x / _imageScrollView.frame.size.width;
    NSLog(@"index is at %d", index);
    
    
    
    [_manager.imageArray removeObjectAtIndex:index];
    
    [self.navigationController popViewControllerAnimated:NO];
    
    [_imageScrollView reloadInputViews];
    
    [_manager.collectionView reloadData];
    
    [_manager updateCollectionViewHeight];
    
    
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
