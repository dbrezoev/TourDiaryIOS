//
//  UpdateToDoViewController.h
//  TourDiary
//
//  Created by admin on 11/7/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Updater.h"
#import "ListItem.h"

@interface UpdateToDoViewController : UIViewController<Updater>

- (IBAction)save:(UIButton *)sender;
- (IBAction)cancelUpdatingTodo:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) ListItem* listItem;
@end
