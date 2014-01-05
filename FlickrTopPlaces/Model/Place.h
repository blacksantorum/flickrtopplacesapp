//
//  Place.h
//  TopPlaces
//
//  Created by Chris Tibbs on 12/28/13.
//  Copyright (c) 2013 Chris Tibbs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject

@property (nonatomic,strong) NSString *placeID;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *state;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
