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
#import "LandmarkViewCell.h"
#import "InfoViewController.h"

@interface LandmarkViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *landmarkTableView;

@end
