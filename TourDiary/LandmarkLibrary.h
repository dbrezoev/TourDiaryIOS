//
//  LandmarkLibrary.h
//  TourDiary
//
//  Created by plamen on 11/10/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "LandmarkItem.h"

@interface LandmarkLibrary : NSObject

@property (nonatomic, assign) BOOL allItemsLoaded;

+ (instancetype)sharedLibraty;
-(NSMutableArray *) allItems;

@end
