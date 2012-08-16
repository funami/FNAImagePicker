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

#define DEFAULT_LANDSCAPE_COLUMN_NUMBER 6
#define DEFAULT_PORTLATE_COLUMN_NUMBER 4

@interface FNAAlbumContentsViewController ()
{
    NSUInteger _lastSeletedPhotoIndex;
}
@property (nonatomic,strong) NSMutableArray *assets;
@property (nonatomic,assign) FNAImagePickerThumbnailView *lastSeletedThumbnailView;
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
    _lastSeletedPhotoIndex = NSNotFound;
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
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            self.columnCount = DEFAULT_LANDSCAPE_COLUMN_NUMBER;
            break;
            
        default:
            self.columnCount = DEFAULT_PORTLATE_COLUMN_NUMBER;
            break;
    }
    [self.tableView reloadData];
    if (_lastSeletedPhotoIndex != NSNotFound){
        NSUInteger row = floor(_lastSeletedPhotoIndex /self.columnCount );
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row -1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
   
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            self.columnCount = DEFAULT_LANDSCAPE_COLUMN_NUMBER;
            break;
            
        default:
            self.columnCount = DEFAULT_PORTLATE_COLUMN_NUMBER;
            break;
    }
    
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
    [self.tableView reloadData];
    if (_lastSeletedPhotoIndex != NSNotFound){
        NSUInteger row = floor(_lastSeletedPhotoIndex /self.columnCount );
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row -1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
    }
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
    return ceil((float)_assets.count /self.columnCount ); // there are four photos per row.
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger firstPhotoInCell = indexPath.row * self.columnCount;
    NSUInteger lastPhotoInCell  = firstPhotoInCell + self.columnCount;
    FNAAlbumContentsTableViewCell *acell = (FNAAlbumContentsTableViewCell *)cell;
    [cell prepareForReuse];
    acell.columnCount = self.columnCount;
    //NSLog(@"acell:%@",acell);
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
            
            [acell setThumbnail:thumbnail atCurrentPhotoIndex:currentPhotoIndex firstPhotoInCell:(NSInteger)firstPhotoInCell delegate:self];
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
    NSUInteger tag = [(UIView *)sender tag];
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

#pragma mark - FNAImagePickerThumbnailView delegate
- (void)thumbnailImageViewWasSelected:(FNAImagePickerThumbnailView *)thumbnailView
{
    [thumbnailView clearSelection];

    _lastSeletedPhotoIndex = thumbnailView.tag;
    
    [self performSegueWithIdentifier:@"ShowImagePickerDetailView" sender:thumbnailView];
}
@end
