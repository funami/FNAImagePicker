//
//  FNAImagePickerDetailViewController.m
//  FNAImagePicker
//
//  Created by Funami Takao on 2012/08/10.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import "FNAImagePickerDetailViewController.h"

@interface FNAImagePickerDetailViewController ()

@end

@implementation FNAImagePickerDetailViewController
@synthesize imageView;

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
    //CGImageRef thumbnailImageRef = [_asset thumbnail];
    //UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];

    ALAssetRepresentation *assetRepresentation = [_asset defaultRepresentation];
    
    UIImage *fullScreenImage = [UIImage imageWithCGImage:[assetRepresentation fullScreenImage] scale:[assetRepresentation scale] orientation:(UIImageOrientation)UIImageOrientationUp];

    NSLog(@"assetRepresentation:%d",[assetRepresentation orientation]);
    
    self.imageView.image = fullScreenImage;
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    //return YES;
}

@end
