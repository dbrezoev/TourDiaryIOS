//
//  ToDoItem.h
//  TourDiary
//
//  Created by admin on 11/2/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic) BOOL completed;
-(id)initWithContent:(NSString*)text;
+(id)toDoItemWithContent:(NSString*)text;

@end
