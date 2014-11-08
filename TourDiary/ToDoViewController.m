//
//  ViewController.m
//  TourDiary
//
//  Created by admin on 11/1/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "ToDoViewController.h"
#import "CreateToDoViewController.h"
#import "UpdateToDoViewController.h"
#import "ToDoItem.h"
#import "CustomTableViewCell.h"
#import "CoreDataHelper.h"
#import "ListItem.h"

@interface ToDoViewController ()
@property(nonatomic, strong) CoreDataHelper* cdHelper;
@end

@implementation ToDoViewController{
    NSMutableArray* _toDoItems;
    NSMutableArray* fetched;
}

static const float DEFAULT_ROW_HEIGHT = 50.0f;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"%@", self.landmarkItem.itemId);
    _toDoItems = [NSMutableArray array];
    _cdHelper = [[CoreDataHelper alloc] init];
    [_cdHelper setupCoreData];
    
    // Set the view as datasource
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [self updateUI];
}

#pragma mark - UITableViewDataSource protocol methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return fetched.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    ListItem *item = fetched[[indexPath row]];
    cell.textLabel.text = item.content;
    cell.delegate = self;
    cell.todoItem = item;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        return [UIColor colorWithRed: 0.690 green: 0.769 blue: 0.871 alpha:1.0];
    }
    else{
        return [UIColor colorWithRed: 0.255 green:0.412 blue: 0.882 alpha:1.0];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"createTodo"])
    {
        CreateToDoViewController *viewControllerToGo = [segue destinationViewController];
        viewControllerToGo.landmarkItem = self.landmarkItem;
    }
//    else if([[segue identifier] isEqualToString:@"UpdateIdentifier"]){
//        UpdateToDoViewController* updateController = [segue destinationViewController];
//        updateController.listItem = self.
//    }
}

#pragma mark - CoreData CRUD operations
-(void)update:(ListItem*) item{
    
//    [self performSegueWithIdentifier:@"UpdateIdentifier" sender:self];
//    NSLog(@"%@",item.content);
}

-(void) addItem:(ToDoItem*)todoItem{
    ListItem* itemToAdd =
    [NSEntityDescription insertNewObjectForEntityForName:@"ListItem" inManagedObjectContext:_cdHelper.context];
    
    itemToAdd.content = todoItem.content;
    itemToAdd.itemId = self.landmarkItem.itemId;
    itemToAdd.dateCreated = [NSDate date];
    
    [self.cdHelper.context insertObject:itemToAdd];
    [self.cdHelper saveContext];
    [self updateUI];
    NSLog(@"List item: %@ added successfully", todoItem.content);
}

-(void)deleteItem:(ListItem*)todoItem {
    
    [_cdHelper.context deleteObject:todoItem];
    [self.cdHelper saveContext];
    [self updateUI];
    
    float delay = 0.0;
    
    // find the visible cells
    NSArray* visibleCells = [self.tableView visibleCells];
    
    UIView* lastView = [visibleCells lastObject];
    bool startAnimating = false;
    
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

-(void) updateUI{
    NSString* itemId = self.landmarkItem.itemId;
    
    NSFetchRequest* request =
    [NSFetchRequest fetchRequestWithEntityName:@"ListItem"];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"itemId = %@", itemId];
    [request setPredicate:predicate];
    fetched = [[_cdHelper.context executeFetchRequest:request error:nil]mutableCopy];
}

- (IBAction)backButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end