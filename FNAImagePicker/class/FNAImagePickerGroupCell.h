//
//  FNAImagePickerGroupCell.h
//  FNAImagePicker
//
//  Created by funami on 2012/08/04.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNAImagePickerGroupCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *countTextLabel;

@end
