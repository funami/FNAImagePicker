//
//  FNAImagePickerGroupViewController.m
//  FNAImagePicker
//
//  Created by funami on 2012/08/04.
//  Copyright (c) 2012年 funami. All rights reserved.
//

#import "FNAImagePickerGroupViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "FNAImagePickerGroupCell.h"
#import "FNAAlbumContentsViewController.h"
#import "FNAImagePickerController.h"


@interface FNAImagePickerGroupViewController ()
{
    ALAssetsLibrary *_assetsLibrary;
    NSMutableArray *_groups;
}
@end

@implementation FNAImagePickerGroupViewController
#pragma mark - View lifecycle

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
    
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    if (!_groups) {
        _groups = [[NSMutableArray alloc] init];
    } else {
        [_groups removeAllObjects];
    }
    
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group) {
            //[_groups addObject:group];
            [_groups insertObject:group atIndex:0];
        } else {
            [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        
    };
    
    NSUInteger groupTypes = ALAssetsGroupAll | ALAssetsGroupEvent | ALAssetsGroupFaces;
    [_assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
    
    self.title = NSLocalizedString(@"Albums", @"Albums");

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_groups count];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    FNAImagePickerGroupCell *gCell = (FNAImagePickerGroupCell *)cell;
    ALAssetsGroup *groupForCell = [_groups objectAtIndex:indexPath.row];
    
    FNAImagePickerController *picker = (FNAImagePickerController *)[self navigationController];
    if (picker.mediaTypes.count == 1){
        if ([picker.mediaTypes[0] isEqualToString:(NSString *)kUTTypeImage]){
            ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
            [groupForCell setAssetsFilter:onlyPhotosFilter];
        }else if ([picker.mediaTypes[0] isEqualToString:(NSString *)kUTTypeVideo]){
            ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allVideos];
            [groupForCell setAssetsFilter:onlyPhotosFilter];
        }
    }
        
        
     

    CGImageRef posterImageRef = [groupForCell posterImage];
    UIImage *posterImage = [UIImage imageWithCGImage:posterImageRef];
    gCell.myImageView.image = posterImage;
    NSString *cellText = [groupForCell valueForProperty:ALAssetsGroupPropertyName];
    
    
    int photoCount = [groupForCell numberOfAssets];
    gCell.nameTextLabel.text = cellText;
    gCell.countTextLabel.text = [NSString stringWithFormat:@"(%d)",photoCount];
    //gCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FNAImagePickerGroupCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlbumContents"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ALAssetsGroup *groupForCell = [_groups objectAtIndex:indexPath.row];
        [[segue destinationViewController] setAssetsGroup:groupForCell];
    }
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

- (IBAction)cancel:(id)sender {
    [(FNAImagePickerController *)self.navigationController cancel];
}
@end
