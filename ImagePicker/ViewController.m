//
//  ViewController.m
//  ImagePicker
//
//  Created by 董志玮 on 2019/4/30.
//  Copyright © 2019 董志玮. All rights reserved.
//

#import "ViewController.h"
#import "Demo2ViewController.h"
@interface ViewController () <imageProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    
    Demo2ViewController *myFriendVc = [Demo2ViewController new];
    [self addChildViewController:myFriendVc];
    myFriendVc.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/3);
    myFriendVc.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:myFriendVc.view];
    self.navigationItem.rightBarButtonItem = myFriendVc.navigationItem.rightBarButtonItem;
    myFriendVc.delegate = self;
}

-(void)selectedImages:(UIImage *)image {
    
}

@end
