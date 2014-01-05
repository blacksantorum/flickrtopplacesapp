//
//  ListOfPhotosForPlaceViewController.m
//  FlickrTopPlaces
//
//  Created by Chris Tibbs on 1/4/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import "ListOfPhotosForPlaceViewController.h"
#import "FlickrFetcher.h"
#import "Place.h"
#import "Photo.h"

@interface ListOfPhotosForPlaceViewController ()

@property (nonatomic,strong) NSArray *photos;

@end

@implementation ListOfPhotosForPlaceViewController

-(NSString *)cellTitleForPhoto:(Photo *)photo
{
    NSString *cellTitle = [[NSString alloc] init];
    if ([photo.title length]) {
        cellTitle = photo.title;
    } else if ([photo.photoDescription length]) {
        cellTitle = photo.photoDescription;
    } else {
        cellTitle = @"Unknown";
    }
    return cellTitle;
}

-(NSString *)cellSubtitleForPhoto:(Photo *)photo
{
    NSString *cellSubtitle = [[NSString alloc] init];
    if ([photo.title length]) {
        cellSubtitle = photo.photoDescription;
    } else {
        cellSubtitle = @"";
    }
    return cellSubtitle;
}

-(NSURL *)urlForCall
{
    return [FlickrFetcher URLforPhotosInPlace:self.place.placeID maxResults:50];
}

-(NSString *)stringForAccess
{
    return FLICKR_RESULTS_PHOTOS;
}

-(void)configureDataSource
{
    NSMutableArray *photoArray = [[NSMutableArray alloc] init];
    for (NSDictionary *p in self.dataForTableRows) {
        Photo *photo = [[Photo alloc] initWithDictionary:p];
        [photoArray addObject:photo];
    }
    self.photos = photoArray;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"List Of Photos Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Photo *photo = self.photos[indexPath.row];
    
    cell.textLabel.text = [self cellTitleForPhoto:photo];
    cell.detailTextLabel.text = [self cellSubtitleForPhoto:photo];
    
    return cell;
}

@end
