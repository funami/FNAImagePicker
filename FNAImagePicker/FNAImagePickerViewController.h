//
//  FNAImagePickerViewController.h
//  FNAImagePicker
//
//  Created by funami on 2012/08/04.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNAImagePickerController.h"


@interface FNAImagePickerViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
- (IBAction)selectPhoto:(id)sender;

@end
