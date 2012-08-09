//
//  FNAImagePickerViewController.h
//  FNAImagePicker
//
//  Created by funami on 2012/08/06.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNAImagePickerController.h"


@interface FNAImagePickerViewController : UIViewController<UINavigationControllerDelegate,FNAImagePickerControllerDelegate>

- (IBAction)selectPhoto:(id)sender;
- (IBAction)selectVideo:(id)sender;

@end
