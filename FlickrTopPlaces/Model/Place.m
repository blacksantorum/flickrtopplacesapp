//
//  Place.m
//  TopPlaces
//
//  Created by Chris Tibbs on 12/28/13.
//  Copyright (c) 2013 Chris Tibbs. All rights reserved.
//

#import "Place.h"

@implementation Place

-(instancetype)initWithDictionary:(NSString *)dictionary
{
    self = [super init];
    if (self) {
        _placeID = [dictionary valueForKey:@"place_id"];
        NSString *placeString = [dictionary valueForKey:@"_content"];
        NSArray *elementsOfPlaceString = [placeString componentsSeparatedByString:@", "];
        
        _name = elementsOfPlaceString[0];
        _state = elementsOfPlaceString[1];
        _country = [elementsOfPlaceString lastObject];
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@",self.name,self.state,self.country];
}

@end
