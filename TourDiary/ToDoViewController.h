//
//  ViewController.h
//  TourDiary
//
//  Created by admin on 11/1/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellDelegate.h"
#import "ListItem.h"
#import "LandmarkItem.h"

@interface ToDoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate>
- (IBAction)backButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) LandmarkItem *landmarkItem;
@end

