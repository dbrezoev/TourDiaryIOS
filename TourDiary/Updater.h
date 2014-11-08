//
//  Updater.h
//  TourDiary
//
//  Created by admin on 11/8/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListItem.h"

@protocol Updater <NSObject>
-(void) update:(ListItem*)todoItem;
@end
