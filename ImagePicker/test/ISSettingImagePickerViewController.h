//
//  Demo2ViewController.h
//  照片选择器
//
//  Created by 洪欣 on 17/2/17.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol imageProtocol <NSObject>
-(void)heightForCellChanged;
-(void)selectedImages:(UIImage *)image;

@end

@interface ISSettingImagePickerViewController : UIViewController
@property (nonatomic, weak) id<imageProtocol>delegate;
@end
