//
//  LandmarkItem.h
//  TourDiary
//
//  Created by plamen on 11/5/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LandmarkItem : NSObject

@property (nonatomic) NSString *itemId;
@property (nonatomic) NSData *imageData;
@property (nonatomic, copy) NSString *landmarkLabel;
@property (nonatomic, copy) NSString *landmarkCity;
@property (nonatomic, copy) NSString *lmDescription;
@property CLLocationCoordinate2D geoPoint;
-(instancetype)initLandmark:(NSData *)imageData withLabel:(NSString *)label withCity:(NSString *)city;
+(LandmarkItem *)initItemWithImage:(NSData *)imageData withLabel:(NSString *)label withCity:(NSString *)city;

@end
