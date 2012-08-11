//
//  FNAImagePickerController.h
//  FNAImagePicker
//
//  Created by funami on 2012/08/05.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNAImagePickerController;
@protocol FNAImagePickerControllerDelegate<NSObject>
@optional
- (void)imagePickerController:(FNAImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (void)imagePickerControllerDidCancel:(FNAImagePickerController *)picker;

@end

@interface FNAImagePickerController : UINavigationController

@property (nonatomic, assign) UIStatusBarStyle orgStatusBarStyle;
@property (nonatomic, assign) id<UINavigationControllerDelegate, FNAImagePickerControllerDelegate> delegate;
@property (nonatomic, copy) NSArray *mediaTypes;

- (void)cancel;

@end
