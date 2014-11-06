//
//  TableViewCellDelegate.h
//  TourDiary
//
//  Created by admin on 11/2/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "ToDoItem.h"
#import "ListItem.h"


@protocol TableViewCellDelegate <NSObject>
-(void) deleteItem:(ListItem*)todoItem;
-(void) addItem:(ToDoItem*)todoItem;
@end
