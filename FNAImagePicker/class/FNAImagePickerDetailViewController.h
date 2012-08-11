//
//  FNAImagePickerDetailViewController.h
//  FNAImagePicker
//
//  Created by Funami Takao on 2012/08/10.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface FNAImagePickerDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) ALAsset *asset;
@end
