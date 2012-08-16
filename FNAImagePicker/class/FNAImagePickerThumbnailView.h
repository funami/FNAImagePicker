//
//  FNAImagePickerThumbnailView.h
//  FNAImagePicker
//
//  Created by funami on 2012/08/12.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNAImagePickerThumbnailView;
@protocol FNAImagePickerThumbnailViewDelegate <NSObject>
- (void)thumbnailImageViewWasSelected:(FNAImagePickerThumbnailView *)thumbnailView;
@end

@interface FNAImagePickerThumbnailView : UIImageView
@property (nonatomic,assign) id delegate;

- (void)clearSelection;

@end
