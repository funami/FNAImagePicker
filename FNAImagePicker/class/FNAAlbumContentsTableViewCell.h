//
//  FNAAlbumContentsTableViewCell.h
//  FNAImagePicker
//
//  Created by funami on 2012/08/08.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNAImagePickerThumbnailView.h"


@interface FNAAlbumContentsTableViewCell : UITableViewCell



@property (nonatomic, assign) NSUInteger columnCount;
@property (nonatomic, assign) NSUInteger rowNumber;

- (void)setThumbnail:(UIImage *)thumbnail atCurrentPhotoIndex:(NSUInteger)currentPhotoIndex firstPhotoInCell:(NSInteger)firstPhotoInCell delegate:(id<FNAImagePickerThumbnailViewDelegate>)delegate;
@end
