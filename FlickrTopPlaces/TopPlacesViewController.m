//
//  TopPlacesViewController.m
//  FlickrTopPlaces
//
//  Created by Chris Tibbs on 1/4/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import "TopPlacesViewController.h"
#import "FlickrFetcher.h"
#import "Place.h"
#import "ListOfPhotosForPlaceViewController.h"

@interface TopPlacesViewController ()

@property (nonatomic,strong) NSArray *places;
@property (nonatomic,strong) NSArray *countries;

-(NSArray *)placesInCountry:(NSString *)country;
@end

@implementation TopPlacesViewController

#pragma mark -Customization for Call

-(NSURL *)urlForCall
{
    return [FlickrFetcher URLforTopPlaces];
}

-(NSString *)stringForAccess
{
    return FLICKR_RESULTS_PLACES;
}

-(NSArray *)placesInCountry:(NSString *)country
{
    NSMutableArray *placesInCountry = [[NSMutableArray alloc] init];
    for (Place *p in self.places) {
        if ([p.country isEqualToString:country]) {
            [placesInCountry addObject:p];
        }
    }
    return placesInCountry;
}

-(void)configureDataSource
{
    NSMutableArray *placesArray = [[NSMutableArray alloc] init];
    for (NSDictionary *p in self.dataForTableRows) {
        Place *place = [[Place alloc] initWithDictionary:p];
        [placesArray addObject:place];
    }
    self.places = placesArray;
    
    NSMutableArray *countryArray = [[NSMutableArray alloc] init];
    for (Place *p in self.places) {
        [countryArray addObject:p.country];
    }
    NSSet *countriesSet = [[NSSet alloc] initWithArray:countryArray];
    self.countries = [countriesSet allObjects];
}

#pragma mark - Table View data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.countries count];;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *country = self.countries[section];
    return [[self placesInCountry:country] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Place Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *country = self.countries[indexPath.section];
    NSArray *placesForCountry = [self placesInCountry:country];
    Place *place = placesForCountry[indexPath.row];
    cell.textLabel.text = place.name;
    cell.detailTextLabel.text = place.state;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.countries[section];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"selectPlace"]) {
        ListOfPhotosForPlaceViewController *controller = (ListOfPhotosForPlaceViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        NSString *country = [self.countries objectAtIndex:indexPath.section];
        NSArray *placesInCountry = [self placesInCountry:country];
        
        controller.place = placesInCountry[indexPath.row];
    }
}

@end
