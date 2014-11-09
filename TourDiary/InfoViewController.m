//
//  InfoViewController.m
//  TourDiary
//
//  Created by plamen on 11/8/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@property (strong, nonatomic) AudioController *audioController;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"LandmarkInfo"];
    [query whereKey:@"objectId" equalTo:self.landmarkItem.itemId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                self.landmarkItem.lmDescription = object[@"Description"];
                self.landmarkDescription.text = self.landmarkItem.lmDescription;
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    UIImage *image = [UIImage imageWithData:self.landmarkItem.imageData];
    [self.extendedImageView setImage:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewNotes:(id)sender {
    [self performSegueWithIdentifier:@"toToDoController" sender:sender];
}

- (IBAction)notifyMe:(id)sender {
//    self.musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
//    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeAny];
//    mediaPicker.delegate = self;
//    mediaPicker.allowsPickingMultipleItems = YES;
//    mediaPicker.prompt = @"Select songs to play";
//    [self presentModalViewController:mediaPicker animated:YES];
    NSString *lmName = self.landmarkItem.landmarkLabel;
    NSString *toastMessage = [[NSString alloc] initWithFormat:@"You have registered notifier for \"%@\" landmark",lmName];

    [ToastView showToastInParentView:self.view withText:toastMessage withDuaration:2.5];
    
    [self.locationManager startMonitoringForRegion:[[CLCircularRegion alloc] initWithCenter:self.landmarkItem.geoPoint radius:200.0 identifier:lmName]];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
    localNotification.alertBody = @"You've reached a marked destination!";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    NSString *message = [[NSString alloc] initWithFormat:@"You have reached the \"%@\" landmark! Do you want to open the to-do list?",region.identifier];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Marked landmark reached!"
                          message:message
                          delegate:self  // set nil if you don't want the yes button callback
                          cancelButtonTitle:@"Yes"
                          otherButtonTitles:@"No", nil];
    [alert show];
    
    self.audioController = [[AudioController alloc] init];
    [self.audioController tryPlayMusic];
    
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"Now monitoring for %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)locationManager didUpdateLocations:(NSArray *)locations
{
    self.location = self.locationManager.location;
    double locdeg =(double)self.location.coordinate.latitude;
    NSLog(@"%f",locdeg);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.audioController stopMusic];
        [self performSegueWithIdentifier:@"toToDoController" sender:nil];
    } else {
        [self.audioController stopMusic];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toToDoController"])
    {
        ToDoViewController *toDoController = segue.destinationViewController;
        toDoController.landmarkItem = self.landmarkItem;
    }
}

@end
