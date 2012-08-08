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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)cancel{
    [self.delegate imagePickerControllerDidCancel:self];
}

@end
