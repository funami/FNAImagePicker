//
//  FNAAlbumContentsTableViewCell.h
//  FNAImagePicker
//
//  Created by funami on 2012/08/08.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNAAlbumContentsTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView *photo1;
@property (nonatomic,weak) IBOutlet UIImageView *photo2;
@property (nonatomic,weak) IBOutlet UIImageView *photo3;
@property (nonatomic,weak) IBOutlet UIImageView *photo4;
@property (weak, nonatomic) IBOutlet UIButton *photoButton1;
@property (weak, nonatomic) IBOutlet UIButton *photoButton2;
@property (weak, nonatomic) IBOutlet UIButton *photoButton3;
@property (weak, nonatomic) IBOutlet UIButton *photoButton4;

@property (nonatomic, assign) NSUInteger rowNumber;

@end
