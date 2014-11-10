//
//  InfoViewController.h
//  TourDiary
//
//  Created by plamen on 11/8/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

@import CoreLocation;
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Parse/Parse.h>
#import "LandmarkItem.h"
#import "ToDoViewController.h"
#import "AudioController.h"
#import "ToastView.h"

@interface InfoViewController : UIViewController <CLLocationManagerDelegate, MPMediaPickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *extendedImageView;
@property (weak, nonatomic) IBOutlet UITextView *landmarkDescription;
@property (strong, nonatomic) LandmarkItem *landmarkItem;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MPMusicPlayerController *musicPlayer;
- (IBAction)viewNotes:(id)sender;
- (IBAction)notifyMe:(id)sender;

@end
