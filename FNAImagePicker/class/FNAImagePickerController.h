//
//  FNAImagePickerController.h
//  FNAImagePicker
//
//  Created by funami on 2012/08/05.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNAImagePickerController : UINavigationController

@property (nonatomic, assign) id<UINavigationControllerDelegate, UIImagePickerControllerDelegate> delegate;

@end
