//
//  CreateToDoViewController.m
//  TourDiary
//
//  Created by admin on 11/6/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "CreateToDoViewController.h"
#import "CoreDataHelper.h"
#import "ListItem.h"

@interface CreateToDoViewController ()
@property(nonatomic, strong) CoreDataHelper* cdHelper;
@end

@implementation CreateToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cdHelper = [[CoreDataHelper alloc] init];
    [_cdHelper setupCoreData];
}

//-(void)saveTodo:(UIButton *)sender{
//    ListItem* itemToAdd =
//    [NSEntityDescription insertNewObjectForEntityForName:@"ListItem" inManagedObjectContext:_cdHelper.context];
//    
//    itemToAdd.content = self.userInput.text;
//    
//    [self.cdHelper.context insertObject:itemToAdd];
//    [self.cdHelper saveContext];
//    [self.cdHelper saveContext];
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (IBAction)save:(UIButton *)sender {
 
    ListItem* itemToAdd =
    [NSEntityDescription insertNewObjectForEntityForName:@"ListItem" inManagedObjectContext:_cdHelper.context];
    
    NSString* userInputText = self.userInput.text;
    itemToAdd.content = userInputText;
    
    if (userInputText && userInputText.length) {
        [self.cdHelper.context insertObject:itemToAdd];
        [self.cdHelper saveContext];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter some text" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

- (IBAction)cancelCreatingToDo:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
