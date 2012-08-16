//
//  FNAImagePickerController.m
//  FNAImagePicker
//
//  Created by funami on 2012/08/05.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import "FNAImagePickerController.h"


@interface FNAImagePickerController ()

@end

@implementation FNAImagePickerController

- (id)init
{
    UIStoryboard *imagePickerStoryboard = [UIStoryboard storyboardWithName:@"FNAImagePickerStoryboard" bundle:nil];
    self = [imagePickerStoryboard instantiateInitialViewController];

    return self;    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.orgStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent]; // スタイルの設定

}


- (void)cancel{
    [[UIApplication sharedApplication] setStatusBarStyle:self.orgStatusBarStyle];// スタイルもどす

    [self.delegate imagePickerControllerDidCancel:self];
}

@end
