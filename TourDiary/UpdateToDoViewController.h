//
//  UpdateToDoViewController.h
//  TourDiary
//
//  Created by admin on 11/7/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface UpdateToDoViewController : UIViewController

- (IBAction)save:(UIButton *)sender;
- (IBAction)cancelUpdatingTodo:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
