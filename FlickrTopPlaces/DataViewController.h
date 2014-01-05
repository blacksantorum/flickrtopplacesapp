//
//  DataViewController.h
//  FlickrTopPlaces
//
//  Created by Chris Tibbs on 1/4/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UITableViewController

@property (strong,nonatomic) NSArray *dataForTableRows;

-(NSURL *)urlForCall;
-(NSString *)stringForAccess;
-(void)getDataFromURL;
-(void)configureDataSource;

@end
