//
//  FNAAlbumContentsViewController.m
//  FNAImagePicker
//
//  Created by funami on 2012/08/08.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import "FNAAlbumContentsViewController.h"
#import "FNAAlbumContentsTableViewCell.h"
#import "FNAImagePickerController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "FNAImagePickerDetailViewController.h"

@interface FNAAlbumContentsViewController ()
@property (nonatomic,strong) NSMutableArray *assets;
@end

@implementation FNAAlbumContentsViewController

#pragma mark View lifecycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = [_assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    
    if (!_assets) {
        _assets = [[NSMutableArray alloc] init];
    } else {
        [_assets removeAllObjects];
    }
    
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if (result) {
            [_assets addObject:result];
        }
    };
    
    FNAImagePickerController *picker = (FNAImagePickerController *)[self navigationController];
    if (picker.mediaTypes.count == 1){
        if ([[picker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeImage]){
            ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
            [_assetsGroup setAssetsFilter:onlyPhotosFilter];
        }else if ([[picker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeVideo]){
            ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allVideos];
            [_assetsGroup setAssetsFilter:onlyPhotosFilter];
        }
    }
    
    [_assetsGroup enumerateAssetsUsingBlock:assetsEnumerationBlock];
    
}

#pragma mark - propaty
- (void)setUseAspectRatioThumbnail:(BOOL)useAspectRatioThumbnail
{
    if (_useAspectRatioThumbnail != useAspectRatioThumbnail){
        _useAspectRatioThumbnail = useAspectRatioThumbnail;
        for (UITableViewCell* cell in [self.tableView visibleCells]) {
            [self configureCell:cell atIndexPath:[self.tableView indexPathForCell:cell]];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return ceil((float)_assets.count /4 ); // there are four photos per row.
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger firstPhotoInCell = indexPath.row * 4;
    NSUInteger lastPhotoInCell  = firstPhotoInCell + 4;
    FNAAlbumContentsTableViewCell *acell = (FNAAlbumContentsTableViewCell *)cell;
    acell.photo1.image = nil;
    acell.photo1.backgroundColor = nil;
    acell.photo2.image = nil;
    acell.photo2.backgroundColor = nil;
    acell.photo3.image = nil;
    acell.photo3.backgroundColor = nil;
    acell.photo4.image = nil;
    acell.photo4.backgroundColor = nil;
    acell.photoButton1.enabled = NO;
    acell.photoButton2.enabled = NO;
    acell.photoButton3.enabled = NO;
    acell.photoButton4.enabled = NO;
    acell.rowNumber = indexPath.row;
    
    if (_assets.count > firstPhotoInCell) {
    
        NSUInteger currentPhotoIndex = 0;
        NSUInteger lastPhotoIndex = MIN(lastPhotoInCell, _assets.count);
        for ( ; firstPhotoInCell + currentPhotoIndex < lastPhotoIndex ; currentPhotoIndex++) {
            
            ALAsset *asset = [_assets objectAtIndex:firstPhotoInCell + currentPhotoIndex];
            CGImageRef thumbnailImageRef ;
            if (_useAspectRatioThumbnail){
                thumbnailImageRef = [asset aspectRatioThumbnail];
            }else{
                thumbnailImageRef = [asset thumbnail];
            }
            UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];
            
            switch (currentPhotoIndex) {
                case 0:
                    acell.photo1.image = thumbnail;
                    acell.photo1.backgroundColor = [UIColor blackColor];
                    acell.photoButton1.tag = firstPhotoInCell + currentPhotoIndex ;
                    acell.photoButton1.enabled = YES;
                    break;
                case 1:
                    acell.photo2.image = thumbnail;
                    acell.photo2.backgroundColor = [UIColor blackColor];
                    acell.photoButton2.tag = firstPhotoInCell + currentPhotoIndex;
                    acell.photoButton2.enabled = YES;
                    break;
                case 2:
                    acell.photo3.image = thumbnail;
                    acell.photo3.backgroundColor = [UIColor blackColor];
                    acell.photoButton3.tag = firstPhotoInCell + currentPhotoIndex;
                    acell.photoButton3.enabled = YES;
                    break;
                case 3:
                    acell.photo4.image = thumbnail;
                    acell.photo4.backgroundColor = [UIColor blackColor];
                    acell.photoButton4.tag = firstPhotoInCell + currentPhotoIndex;
                    acell.photoButton4.enabled = YES;
                    break;
                default:
                    break;
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FNAAlbumContentsTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSUInteger tag = [(UIButton *)sender tag];
    ALAsset *asset = [_assets objectAtIndex:tag];
    [[segue destinationViewController] setAsset:asset];

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)toggleThumbnail:(id)sender {
    self.useAspectRatioThumbnail = !self.useAspectRatioThumbnail;
}
@end
