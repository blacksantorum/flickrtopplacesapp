//
//  Photo.h
//  TopPlaces
//
//  Created by Chris Tibbs on 1/2/14.
//  Copyright (c) 2014 Chris Tibbs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property NSString *photoID;
@property NSString *title;
@property NSString *photoDescription;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
