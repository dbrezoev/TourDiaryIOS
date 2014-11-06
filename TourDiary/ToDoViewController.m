//
//  ViewController.m
//  TourDiary
//
//  Created by admin on 11/1/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "ToDoViewController.h"
#import "ToDoItem.h"
#import "CustomTableViewCell.h"

@interface ToDoViewController ()

@end

@implementation ToDoViewController{
    NSMutableArray* _toDoItems;
}

static const float DEFAULT_ROW_HEIGHT = 50.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO: This should be working with CORE DATA
    _toDoItems = [[NSMutableArray alloc] init];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Take photo of the museum"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"See the strange house"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Don't forget to pay the WC"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"See Bob's family"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Take a photo from the peak"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Buy some cheap clothes"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Buy two bateries"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Try bulgarian rakia"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Call Pesho"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Some other note"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Some other note2"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"See Bob's family"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Call Pesho"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Some other note"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Some other note2"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"See Bob's family"]];
    
    // Set the view as datasource
    
    NSLog(@"View did load");
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
}

#pragma mark - UITableViewDataSource protocol methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu",(unsigned long)_toDoItems.count);
    return _toDoItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"cell";
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    ToDoItem *item = _toDoItems[[indexPath row]];
    cell.textLabel.text = item.content;
    NSLog(@"row for index path");
    
    cell.delegate = self;
    cell.todoItem = item;
    [cell setUserInteractionEnabled:YES];
    [tableView setUserInteractionEnabled:YES];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataDelegate protocol methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DEFAULT_ROW_HEIGHT;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [self colorForIndex:indexPath.row];
}

//style the cells
-(UIColor*)colorForIndex:(NSInteger) index {
    //TODO: Change the colors to look better
    if(index % 2 == 0){
        return [UIColor colorWithRed: 1.0 green:0.5 blue: 0.0 alpha:1.0];
    }
    else{
        return [UIColor colorWithRed: 0.0 green:0.5 blue: 1.0 alpha:1.0];
    }
}

-(void)deleteItem:(id)todoItem {
//    // use the UITableView to animate the removal of this row
//    NSUInteger index = [_toDoItems indexOfObject:todoItem];
//    [self.tableView beginUpdates];
//    [_toDoItems removeObject:todoItem];
//    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]
//                          withRowAnimation:UITableViewRowAnimationFade];
//    [self.tableView endUpdates];
    
    float delay = 0.0;
    
    // remove the model object
    [_toDoItems removeObject:todoItem];
    
    // find the visible cells
    NSArray* visibleCells = [self.tableView visibleCells];
    
    UIView* lastView = [visibleCells lastObject];
    bool startAnimating = false;
    
    // iterate over all of the cells
    for(CustomTableViewCell* cell in visibleCells) {
        if (startAnimating) {
            [UIView animateWithDuration:0.3
                                  delay:delay
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 cell.frame = CGRectOffset(cell.frame, 0.0f, -cell.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 if (cell == lastView) {
                                     [self.tableView reloadData];
                                 }
                             }];
            delay+=0.03;
        }
        
        // if you have reached the item that was deleted, start animating
        if (cell.todoItem == todoItem) {
            startAnimating = true;
            cell.hidden = YES;
        }
    }
}
@end
