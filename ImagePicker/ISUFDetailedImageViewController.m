//
//  ISUFDetailedImageViewController.m
//  ImagePicker
//
//  Created by 董志玮 on 2019/5/7.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "ISUFDetailedImageViewController.h"

@interface ISUFDetailedImageViewController ()

@end

@implementation ISUFDetailedImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}
-(void)viewWillAppear:(BOOL)animated{
    
    
}
-(BOOL)prefersStatusBarHidden{
    return self.navigationController.isNavigationBarHidden == true;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
