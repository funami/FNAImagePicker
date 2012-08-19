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
#import "FNAImageGridViewCell.h"
#import <QuartzCore/CALayer.h>

#define DEFAULT_LANDSCAPE_COLUMN_NUMBER 6
#define DEFAULT_PORTLATE_COLUMN_NUMBER 4

@interface FNAAlbumContentsViewController ()
{
    NSUInteger _lastSeletedPhotoIndex;
    NSUInteger _currentCenterCell;
    UIImageView *_tempImageView;
    
}
@property (nonatomic,strong) NSMutableArray *assets;
@property (nonatomic,assign) FNAImagePickerThumbnailView *lastSeletedThumbnailView;
- (void)configureCell:(FNAImageGridViewCell *)cell atIndex:(NSUInteger)index;
@end

@implementation FNAAlbumContentsViewController

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _lastSeletedPhotoIndex = NSNotFound;
    _sizeLevel = 1;
    _gridView.delegate = self;
    _gridView.dataSource = self;
    _gridView.separatorStyle =  AQGridViewCellSeparatorStyleSingleLine;

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

- (UIImage *)imageByCropping:(UIScrollView *)imageToCrop toRect:(CGRect)rect
{
    CGSize pageSize = rect.size;
    UIGraphicsBeginImageContext(pageSize);
    
    CGContextRef resizedContext = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext, -imageToCrop.contentOffset.x, -imageToCrop.contentOffset.y);
    [imageToCrop.layer renderInContext:resizedContext];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

    UIImage *myImage = [self imageByCropping:_gridView toRect:[_gridView gridViewVisibleBounds]];
    UIGraphicsEndImageContext();
    if (_tempImageView){
        [_tempImageView removeFromSuperview];
    }
    _tempImageView = [[UIImageView alloc] initWithImage:myImage];
    _tempImageView.alpha = 1.0;
    [self.view addSubview:_tempImageView];
    
    NSArray *array = [_gridView visibleCells];
    AQGridViewCell *cell = [array objectAtIndex:0];
    _currentCenterCell = [_gridView indexForCell:cell];
    
    _gridView.alpha = 0.0;

}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    _gridView.alpha = 1.0;
    [_gridView scrollToItemAtIndex:_currentCenterCell atScrollPosition:AQGridViewScrollPositionTop animated:NO];
    _tempImageView.alpha = 0.0;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [UIView animateWithDuration:0.3f animations:^{
        
        
        //_tempImageView.alpha = 0.0;
        //_gridView.alpha = 1.0;
    } completion:^(BOOL finished){
        [_tempImageView removeFromSuperview];
        _tempImageView = nil;
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            break;
            
        default:
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
    [_gridView reloadData];

}

#pragma mark - propaty
- (void)setUseAspectRatioThumbnail:(BOOL)useAspectRatioThumbnail
{
    if (_useAspectRatioThumbnail != useAspectRatioThumbnail){
        _useAspectRatioThumbnail = useAspectRatioThumbnail;
        
        for (FNAImageGridViewCell* cell in [_gridView visibleCells]) {
            [self configureCell:cell atIndex:[_gridView indexForCell:cell]];
        }
        
    }
}

- (void)setSizeLevel:(CGFloat)sizeLevel
{
    if (_sizeLevel != sizeLevel){
        _sizeLevel = sizeLevel;
        NSArray *array = [_gridView visibleCells];
        AQGridViewCell *cell = [array objectAtIndex:0];
        _currentCenterCell = [_gridView indexForCell:cell];
        [_gridView reloadData];
        
        [_gridView scrollToItemAtIndex:_currentCenterCell atScrollPosition:AQGridViewScrollPositionTop animated:NO];

        
    }
}

#pragma mark -
#pragma mark Grid View Data Source

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) aGridView
{
    return _assets.count;
}

- (void)configureCell:(FNAImageGridViewCell *)cell atIndex:(NSUInteger)index
{
    ALAsset *asset = [_assets objectAtIndex:index];
    CGImageRef thumbnailImageRef ;
    if (_useAspectRatioThumbnail){
        thumbnailImageRef = [asset aspectRatioThumbnail];
    }else{
        thumbnailImageRef = [asset thumbnail];
    }
    UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];
    cell.image = thumbnail;
    //cell.delegate = self;
}

- (AQGridViewCell *) gridView: (AQGridView *) aGridView cellForItemAtIndex: (NSUInteger) index
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"FNAImageGridViewCell%f",_sizeLevel];
    
    FNAImageGridViewCell * cell = nil;

    cell = (FNAImageGridViewCell *)[aGridView dequeueReusableCellWithIdentifier: CellIdentifier];
    if ( cell == nil )
    {
        cell = [[FNAImageGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 76.0*_sizeLevel, 76.0*_sizeLevel)
                                                 reuseIdentifier: CellIdentifier];
        cell.selectionGlowColor = [UIColor blueColor];
    }
    [self configureCell:cell atIndex:index];
    return ( cell );
}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) aGridView
{
    return ( CGSizeMake(78.0*_sizeLevel, 78.0*_sizeLevel) );
}

#pragma mark -
#pragma mark Grid View Delegate

- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index
{
    
    [self performSegueWithIdentifier:@"ShowImagePickerDetailView" sender:gridView];

}


#pragma mark - UIViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSUInteger tag = [(AQGridView *)sender indexOfSelectedItem];
    ALAsset *asset = [_assets objectAtIndex:tag];
    [[segue destinationViewController] setAsset:asset];

}

- (IBAction)toggleThumbnail:(id)sender {
    self.useAspectRatioThumbnail = !self.useAspectRatioThumbnail;
}

- (IBAction)toggleSize:(id)sender {
    if (self.sizeLevel == 1){
        self.sizeLevel = 2;
    }else{
        self.sizeLevel = 1;
    }
}


@end
