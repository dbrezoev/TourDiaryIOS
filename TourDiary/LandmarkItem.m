//
//  LandmarkItem.m
//  TourDiary
//
//  Created by plamen on 11/5/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "LandmarkItem.h"

@implementation LandmarkItem

-(instancetype)initLandmark:(NSData *)imageData withLabel:(NSString *)label withCity:(NSString *)city{
    if(self =[super init]){
        self.imageData = imageData;
        self.landmarkLabel = label;
        self.landmarkCity = city;
    }
    
    return self;
}

+(LandmarkItem *)initItemWithImage:(NSData *)imageData withLabel:(NSString *)label  withCity:(NSString *)city;{
    return [[LandmarkItem alloc] initLandmark:imageData withLabel:label withCity:city];
}

@end
