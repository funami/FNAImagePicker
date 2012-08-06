//
//  FNAImagePickerViewController.m
//  FNAImagePicker
//
//  Created by funami on 2012/08/04.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import "FNAImagePickerViewController.h"
#import "FNAImagePickerController.h"

@interface FNAImagePickerViewController ()

@end

@implementation FNAImagePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)selectPhoto:(id)sender {
    /*
    UIStoryboard *imagePickerStoryboard = [UIStoryboard storyboardWithName:@"FNAImagePickerStoryboard" bundle:nil];
    UINavigationController *vc = [imagePickerStoryboard instantiateInitialViewController];
    */
    FNAImagePickerController *vc = [[FNAImagePickerController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void) imagePickerGroupViewControllerDidCanceled:(FNAImagePickerController *)imagePickerNavigationController{
    [self dismissModalViewControllerAnimated:YES];
}
- (void) imagePickerGroupViewControllerDidFinished:(FNAImagePickerController *)imagePickerNavigationController withInfo:(NSDictionary *)info{
    
}

@end
