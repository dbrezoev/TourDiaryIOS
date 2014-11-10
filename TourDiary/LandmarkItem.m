//
//  LandmarkItem.m
//  TourDiary
//
//  Created by plamen on 11/5/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "LandmarkItem.h"

@implementation LandmarkItem{
    NSData *imgData;
}

@dynamic LandmarkName;
@dynamic Description;
@dynamic City;
@dynamic Country;
@dynamic Rating;
@dynamic GeoLocation;
@dynamic LandmarkPicture;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"LandmarkInfo";
}

- (NSString *) itemId{
    return self.objectId;
}

-(CLLocationCoordinate2D)geoPoint{
    return CLLocationCoordinate2DMake(self.GeoLocation.latitude, self.GeoLocation.longitude);
}

-(NSData *)imageData{
    [self.LandmarkPicture getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if(!error){
            imgData = imageData;
            self.imageLoaded = [NSNumber numberWithBool:YES];
        }
    }];
    return imgData;
}

@end
