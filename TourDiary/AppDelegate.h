//
//  AppDelegate.h
//  TourDiary
//
//  Created by admin on 11/1/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import "LandmarkViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) UIWindow *window;

@end

