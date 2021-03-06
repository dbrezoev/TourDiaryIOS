//
//  UpdateToDoViewController.m
//  TourDiary
//
//  Created by admin on 11/7/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "UpdateToDoViewController.h"
#import "CoreDataHelper.h"

@interface UpdateToDoViewController ()
@property(nonatomic, strong) CoreDataHelper* cdHelper;
@end

@implementation UpdateToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cdHelper = [[CoreDataHelper alloc] init];
    [_cdHelper setupCoreData];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)save:(UIButton *)sender {
    
    NSString *newTodoContent = self.userInput.text;
    
    if (newTodoContent && newTodoContent.length) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"ListItem" inManagedObjectContext:self.cdHelper.context]];
        
        NSError* error = nil;
        NSArray* results = [self.cdHelper.context executeFetchRequest:request error:&error];
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"content = %@", self.listItem.content];
        [request setPredicate:predicate];
        
        ListItem* itemToBeUpdated = [results objectAtIndex:0];
        itemToBeUpdated.content = newTodoContent;
        [self.cdHelper saveContext];
        
    }
}

-(void)update:(ListItem *)todoItem{
    NSString *newTodoContent = self.userInput.text;
    
    if (newTodoContent && newTodoContent.length) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"ListItem" inManagedObjectContext:self.cdHelper.context]];
        
        NSError* error = nil;
        NSArray* results = [self.cdHelper.context executeFetchRequest:request error:&error];
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"content = %@", self.listItem.content];
        [request setPredicate:predicate];
        
        ListItem* itemToBeUpdated = [results objectAtIndex:0];
        itemToBeUpdated.content = newTodoContent;
        [self.cdHelper saveContext];
        
    }
}

- (IBAction)cancelUpdatingTodo:(UIButton *)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
