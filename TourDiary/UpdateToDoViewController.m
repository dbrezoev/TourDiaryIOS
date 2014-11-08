//
//  UpdateToDoViewController.m
//  TourDiary
//
//  Created by admin on 11/7/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "UpdateToDoViewController.h"

@interface UpdateToDoViewController ()

@end

@implementation UpdateToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)save:(UIButton *)sender {
    NSString *newTodoContent = self.userInput.text;
    
    if (newTodoContent && newTodoContent.length) {
        
    }
}

- (IBAction)cancelUpdatingTodo:(UIButton *)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
