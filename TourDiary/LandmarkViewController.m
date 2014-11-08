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
    UIActivityIndicatorView *spinner;
}

static NSString *cellIndentifier = @"cellIndentifierr";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSpinner];
    PFQuery *query = [PFQuery queryWithClassName:@"LandmarkInfo"];
    _landmarkItems = [[NSMutableArray alloc] init];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *itemId = [object objectId];
                NSString *text = object[@"LandmarkName"];
                NSString *cityName = object[@"City"];
                PFFile *imageFile = object[@"LandmarkPicture"];
                NSData *imageData = [imageFile getData];
                LandmarkItem *landmarkItem = [[LandmarkItem alloc] initLandmark:imageData withLabel:text withCity:cityName];
                landmarkItem.itemId = itemId;
                [_landmarkItems addObject:landmarkItem];
            }
            
            [self.landmarkTableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [spinner stopAnimating];
    }];
    
    self.landmarkTableView.dataSource = self;
    self.landmarkTableView.delegate = self;
    self.landmarkTableView.allowsSelectionDuringEditing = true;
    [self.landmarkTableView registerNib:[UINib nibWithNibName:@"LandmarkTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
}

-(void) loadSpinner {
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake((self.view.frame.size.width / 2), self.view.frame.size.height/2);
    [self.view addSubview:spinner];
    [spinner startAnimating];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"toInfoViewSegue"])
    {
        NSIndexPath *indexPath = (NSIndexPath *) sender;
        LandmarkItem *landmarkItem = [_landmarkItems objectAtIndex:[indexPath row]];
        InfoViewController *infoController = segue.destinationViewController;
        infoController.landmarkItem = landmarkItem;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: Row: selected and its data is");
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"toInfoViewSegue" sender:indexPath];
    
}

@end
