//
//  FNAAlbumContentsViewController.h
//  FNAImagePicker
//
//  Created by funami on 2012/08/08.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AQGridView.h"
#import "FNAImagePickerThumbnailView.h"


@interface FNAAlbumContentsViewController : UIViewController<AQGridViewDelegate, AQGridViewDataSource>
{
    IBOutlet AQGridView * _gridView;
}

@property (nonatomic, retain) ALAssetsGroup *assetsGroup;
@property (nonatomic, assign) BOOL useAspectRatioThumbnail;
- (IBAction)toggleThumbnail:(id)sender;
@end
