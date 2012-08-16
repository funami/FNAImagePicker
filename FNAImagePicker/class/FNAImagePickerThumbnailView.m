//
//  FNAImagePickerThumbnailView.m
//  FNAImagePicker
//
//  Created by funami on 2012/08/12.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import "FNAImagePickerThumbnailView.h"

@interface FNAImagePickerThumbnailView()
@property (nonatomic,strong) UIImageView *highlightView;
@end

@implementation FNAImagePickerThumbnailView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

#pragma mark - Property
- (UIImageView *)highlightView
{
    if (_highlightView == nil){
        _highlightView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    _highlightView.backgroundColor = [UIColor blackColor];
    _highlightView.alpha = 0.5f;
    return _highlightView;
}


#pragma mark - Touch handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.highlightView setImage:self.image];
    [self addSubview:self.highlightView];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_delegate thumbnailImageViewWasSelected:self];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [_highlightView removeFromSuperview];
}

- (void)clearSelection {
    [_highlightView removeFromSuperview];
}



@end
