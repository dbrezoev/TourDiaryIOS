//
//  MapViewController.h
//  TourDiary
//
//  Created by plamen on 11/10/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LandmarkLibrary.h"
#import "LandmarkItem.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate>
@property (retain, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
