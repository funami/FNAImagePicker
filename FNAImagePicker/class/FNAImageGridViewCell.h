//
//  FNAImageGridViewCell.h
//  FNAImagePicker
//
//  Created by funami on 2012/08/16.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import "AQGridViewCell.h"
#import "FNAImagePickerThumbnailView.h"

@interface FNAImageGridViewCell : AQGridViewCell

{
    FNAImagePickerThumbnailView * _imageView;
}
@property (nonatomic, retain) UIImage * image;
@property (nonatomic, assign) id<FNAImagePickerThumbnailViewDelegate>delegate;
@end
