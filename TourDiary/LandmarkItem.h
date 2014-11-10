//
//  LandmarkItem.h
//  TourDiary
//
//  Created by plamen on 11/5/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface LandmarkItem : PFObject<PFSubclassing>

@property (nonatomic) NSString *itemId;
@property (nonatomic) NSData *imageData;
@property CLLocationCoordinate2D geoPoint;

@property (strong, nonatomic) NSString* LandmarkName;
@property (strong, nonatomic) NSString* City;
@property (strong, nonatomic) NSString* Country;
@property (strong, nonatomic) NSNumber* Rating;
@property (strong, nonatomic) PFGeoPoint* GeoLocation;
@property (strong, nonatomic) NSString* Description;
@property (strong, nonatomic) PFFile* LandmarkPicture;
@property (strong, nonatomic) NSNumber* imageLoaded;

@end
