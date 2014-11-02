//
//  ViewController.m
//  TourDiary
//
//  Created by admin on 11/1/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "ToDoViewController.h"
#import "ToDoItem.h"

@interface ToDoViewController ()

@end

@implementation ToDoViewController{
    NSMutableArray* _toDoItems;
}

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
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Remember your wedding anniversary!"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Call Pesho"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Some other note"]];
    [_toDoItems addObject:[ToDoItem toDoItemWithContent:@"Some other note2"]];
    
    // Set the view as datasource
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDataSource protocol methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _toDoItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    ToDoItem *item = _toDoItems[[indexPath row]];
    cell.textLabel.text = item.content;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
