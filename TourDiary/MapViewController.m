//
//  MapViewController.m
//  TourDiary
//
//  Created by plamen on 11/10/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

LandmarkLibrary *landmarkLib;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    landmarkLib = [LandmarkLibrary sharedLibraty];
    
    self.mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    self.locationManager = [[CLLocationManager alloc] init];
   
    if ( [CLLocationManager locationServicesEnabled] ) {
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = 1000;
        [self.locationManager startUpdatingLocation];
    }
    [self.view addSubview:self.mapView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.20;
    span.longitudeDelta = 0.20;
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = newLocation.coordinate;
    
    [self.mapView setRegion:region animated:YES];
    self.mapView.showsUserLocation = YES;
    
    for (LandmarkItem *item in landmarkLib.allItems) {
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = item.geoPoint;
        point.title = item.LandmarkName;
        [self.mapView addAnnotation:point];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
