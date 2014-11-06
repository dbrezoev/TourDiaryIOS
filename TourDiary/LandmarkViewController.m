//
//  LandmarkViewController.m
//  TourDiary
//
//  Created by plamen on 11/5/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "LandmarkViewController.h"

@implementation LandmarkViewController{
    NSMutableArray *_landmarkItems;
}

static NSString *cellIndentifier = @"cellIndentifierr";

- (void)viewDidLoad {
    [super viewDidLoad];
    PFQuery *query = [PFQuery queryWithClassName:@"LandmarkInfo"];
    _landmarkItems = [[NSMutableArray alloc] init];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *text = object[@"LandmarkName"];
                NSString *cityName = object[@"City"];
                PFFile *imageFile = object[@"LandmarkPicture"];
                NSData *imageData = [imageFile getData];
                LandmarkItem *landmarkItem = [[LandmarkItem alloc] initLandmark:imageData withLabel:text withCity:cityName];
                [_landmarkItems addObject:landmarkItem];
            }
            
            [self.landmarkTableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    self.landmarkTableView.dataSource = self;
    [self.landmarkTableView registerNib:[UINib nibWithNibName:@"LandmarkTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _landmarkItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LandmarkViewCell *cell = (LandmarkViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    [cell setBackgroundColor:[UIColor clearColor]];
    LandmarkItem *landmarkItem = _landmarkItems[indexPath.row];
    
    UIImage *image = [UIImage imageWithData:landmarkItem.imageData];
    [cell.landmarkImage setImage:image];
     cell.landmarkName.text = landmarkItem.landmarkLabel;
     cell.landmarkCity.text = landmarkItem.landmarkCity;
    
    return cell;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
