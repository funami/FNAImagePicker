//
//  FNAAlbumContentsTableViewCell.m
//  FNAImagePicker
//
//  Created by funami on 2012/08/08.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import "FNAAlbumContentsTableViewCell.h"

#define PADDING 2.0f

@interface FNAAlbumContentsTableViewCell()

    
@property (nonatomic,strong) NSMutableArray *thumbnailViews;

@end

@implementation FNAAlbumContentsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    for (FNAImagePickerThumbnailView *thumbnailView in self.thumbnailViews){
        thumbnailView.hidden = YES;
    }
    
}

- (NSArray *)thumbnailViews
{
    if (!_thumbnailViews){
        _thumbnailViews = [NSMutableArray array];
    }
    return _thumbnailViews;
}


- (void)setThumbnail:(UIImage *)thumbnail atCurrentPhotoIndex:(NSUInteger)currentPhotoIndex firstPhotoInCell:(NSInteger)firstPhotoInCell delegate:(id<FNAImagePickerThumbnailViewDelegate>)delegate
{
    FNAImagePickerThumbnailView *thumbnailView = nil;
    if ([self.thumbnailViews count] > currentPhotoIndex){
        thumbnailView = [self.thumbnailViews objectAtIndex:currentPhotoIndex];
    }
    if (thumbnailView == nil){
        CGFloat side = self.bounds.size.height - PADDING;
        CGRect rect = CGRectMake(PADDING + (side+PADDING)*currentPhotoIndex, PADDING, side, side);
        thumbnailView = [[FNAImagePickerThumbnailView alloc] initWithFrame:rect];
        thumbnailView.contentMode = UIViewContentModeScaleAspectFit;
        [self.thumbnailViews insertObject:thumbnailView atIndex:currentPhotoIndex];
        [self.contentView addSubview:thumbnailView];
        
    }
    thumbnailView.delegate = delegate;
    thumbnailView.tag = firstPhotoInCell + currentPhotoIndex ;
    thumbnailView.hidden = NO;
    [thumbnailView setImage:thumbnail];
    thumbnailView.backgroundColor = [UIColor blackColor];
}

@end
