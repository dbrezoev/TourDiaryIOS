//
//  CoreDataHelper.h
//  TourDiary
//
//  Created by admin on 11/5/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

@property (nonatomic, strong) NSManagedObjectContext* context;
@property (nonatomic, strong) NSManagedObjectModel* model;
@property (nonatomic, strong) NSPersistentStoreCoordinator* cordinator;
@property (nonatomic, strong) NSPersistentStore* store;

-(void)saveContext;
-(void)setupCoreData;
@end
