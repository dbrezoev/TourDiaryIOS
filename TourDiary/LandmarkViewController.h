//
//  LandmarkViewController.h
//  TourDiary
//
//  Created by plamen on 11/5/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TableViewCellDelegate.h"
#import "LandmarkItem.h"
#import "LandmarkLibrary.h"
#import "LandmarkViewCell.h"
#import "InfoViewController.h"

@interface LandmarkViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *landmarkTableView;
@property (strong, nonatomic) InfoViewController *infoViewController;

@end
