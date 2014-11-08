//
//  InfoViewController.h
//  TourDiary
//
//  Created by plamen on 11/8/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LandmarkItem.h"
#import "ToDoViewController.h"

@interface InfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *extendedImageView;
@property (weak, nonatomic) IBOutlet UILabel *landmarkDescription;
@property (strong, nonatomic) LandmarkItem *landmarkItem;
- (IBAction)clickBack:(id)sender;
- (IBAction)viewNotes:(id)sender;

@end
