//
//  CreateToDoViewController.h
//  TourDiary
//
//  Created by admin on 11/6/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LandmarkItem.h"

@interface CreateToDoViewController : UIViewController

- (IBAction)save:(UIButton *)sender;
- (IBAction)cancelCreatingToDo:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) LandmarkItem *landmarkItem;
@end
