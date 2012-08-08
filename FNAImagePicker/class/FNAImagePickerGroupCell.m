//
//  FNAImagePickerGroupCell.m
//  FNAImagePicker
//
//  Created by funami on 2012/08/04.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import "FNAImagePickerGroupCell.h"

@implementation FNAImagePickerGroupCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    static float padding1 = 10.0f;
    static float padding2 = 8.0f;
    static float padding3 = 5.0f;
    [self.countTextLabel sizeToFit];
    [self.nameTextLabel sizeToFit];
    
    CGRect nameTextLabelRect = self.nameTextLabel.frame;
    CGRect countTextLabelRect = self.countTextLabel.frame;
    
    CGFloat offsetX = self.myImageView.frame.origin.x + self.myImageView.frame.size.width + padding1;
    nameTextLabelRect.origin.x = offsetX;
    if ((self.contentView.bounds.size.width - offsetX) - (nameTextLabelRect.size.width + padding2 + countTextLabelRect.size.width + padding3) < 0){
        nameTextLabelRect.size.width = (self.contentView.bounds.size.width - offsetX) - (padding2 + countTextLabelRect.size.width + padding3);
    }
    self.nameTextLabel.frame = nameTextLabelRect;
    countTextLabelRect.origin.x = self.nameTextLabel.frame.origin.x + self.nameTextLabel.frame.size.width + padding2;
    self.countTextLabel.frame = countTextLabelRect;
}
@end
