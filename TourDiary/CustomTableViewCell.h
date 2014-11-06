//
//  CustomTableViewCell.h
//  TourDiary
//
//  Created by admin on 11/2/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"
#import "ListItem.h"
#import "TableViewCellDelegate.h"

@interface CustomTableViewCell : UITableViewCell <UIGestureRecognizerDelegate>
// The item that this cell renders.
@property (nonatomic) ListItem *todoItem;

// The object that acts as delegate for this cell.
@property (nonatomic, assign) id<TableViewCellDelegate> delegate;
@end
