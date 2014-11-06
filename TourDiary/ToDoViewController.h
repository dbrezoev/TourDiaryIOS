//
//  ViewController.h
//  TourDiary
//
//  Created by admin on 11/1/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellDelegate.h"

@interface ToDoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate>
//- (IBAction)createToDo:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

