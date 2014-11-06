//
//  ToDoItem.m
//  TourDiary
//
//  Created by admin on 11/2/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

-(id)initWithContent:(NSString*)content {
    if (self = [super init]) {
        self.content = content;
        self.completed = @0;
    }
    return self;
}

+(id)toDoItemWithContent:(NSString *)content {
    return [[ToDoItem alloc] initWithContent:content];
}
@end
