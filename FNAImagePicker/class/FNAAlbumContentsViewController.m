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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    acell.photo2.image = nil;
    acell.photo3.image = nil;
    acell.photo4.image = nil;
    
    if (_assets.count > firstPhotoInCell) {
    
        NSUInteger currentPhotoIndex = 0;
        NSUInteger lastPhotoIndex = MIN(lastPhotoInCell, _assets.count);
        for ( ; firstPhotoInCell + currentPhotoIndex < lastPhotoIndex ; currentPhotoIndex++) {
            
            ALAsset *asset = [_assets objectAtIndex:firstPhotoInCell + currentPhotoIndex];
            CGImageRef thumbnailImageRef = [asset thumbnail];
            UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];
            
            switch (currentPhotoIndex) {
                case 0:
                    acell.photo1.image = thumbnail;
                    break;
                case 1:
                    acell.photo2.image = thumbnail;
                    break;
                case 2:
                    acell.photo3.image = thumbnail;
                    break;
                case 3:
                    acell.photo4.image = thumbnail;
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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

@end
