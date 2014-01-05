//
//  DataViewController.m
//  FlickrTopPlaces
//
//  Created by Chris Tibbs on 1/4/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import "DataViewController.h"
#import <AFHTTPRequestOperation.h>

@interface DataViewController ()

@end

@implementation DataViewController

#pragma mark - Customizing Calls and Handling Data for Subclasses

-(NSURL *)urlForCall
{
    // must override
    return nil;
}

-(NSString *)stringForAccess
{
    //must override
    return nil;
}

-(void)configureDataSource
{
    // must override
}

#pragma mark - Table view data source for Subclasses

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // must override
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // must override
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Shouldn't need to override these methods

-(void)getDataFromURL
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[self urlForCall]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"Connection error: %@", connectionError);
        } else {
            NSError *error = nil;
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (error) {
                NSLog(@"JSON parsing error: %@", error);
            } else {
                self.dataForTableRows = [object valueForKeyPath:[self stringForAccess]];
                // NSLog(@"%@",self.dataForTableRows);
                [self configureDataSource];
                [self.tableView reloadData];
            }
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self getDataFromURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
