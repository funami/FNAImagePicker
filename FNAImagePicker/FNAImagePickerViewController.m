//
//  FNAImagePickerViewController.m
//  FNAImagePicker
//
//  Created by funami on 2012/08/06.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import "FNAImagePickerViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface FNAImagePickerViewController ()

@end

@implementation FNAImagePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
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
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)selectPhoto:(id)sender {
    FNAImagePickerController *pickerUI = [[FNAImagePickerController alloc] init];
    pickerUI.delegate = self;
    pickerUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    [self presentViewController:pickerUI animated:YES completion:nil];
}

- (IBAction)selectVideo:(id)sender {
    FNAImagePickerController *pickerUI = [[FNAImagePickerController alloc] init];
    pickerUI.delegate = self;
    pickerUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeVideo, nil];
    [self presentViewController:pickerUI animated:YES completion:nil];
}

#pragma mark - FNAImagePickerControllerDelegate
- (void)imagePickerController:(FNAImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
}
- (void)imagePickerControllerDidCancel:(FNAImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}


@end
