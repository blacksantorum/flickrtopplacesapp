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

-(NSURL *)urlForCall
{
    return [FlickrFetcher URLforPhotosInPlace:@"rEBdGBNVV787224" maxResults:50];
    // return [FlickrFetcher URLforPhotosInPlace:self.place.placeID maxResults:50];
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
    NSLog(@"%@",photo);
    
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.photoDescription;
    return cell;
}

@end
