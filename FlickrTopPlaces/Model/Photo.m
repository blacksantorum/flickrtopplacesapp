//
//  Photo.m
//  TopPlaces
//
//  Created by Chris Tibbs on 1/2/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        _photoID = [dictionary valueForKey:@"id"];
        _title = [dictionary valueForKey:@"title"];
        _photoDescription = [dictionary valueForKeyPath:@"description._content"];
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@",self.photoID,self.title,self.photoDescription];
}

@end
