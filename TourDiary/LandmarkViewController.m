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
    NSTimer *oneSecondTimer;
    LandmarkLibrary *landmarkLib;
}

static NSString *cellIndentifier = @"cellIndentifierr";

typedef void(^connection)(BOOL);

- (void)checkInternet:(connection)block
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://www.google.com/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"HEAD";
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    request.timeoutInterval = 10.0;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         block([(NSHTTPURLResponse *)response statusCode] == 200);
     }];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        exit(0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSpinner];
    
    [self checkInternet:^(BOOL internet)
     {
         if (internet)
         {
             _landmarkItems = [[NSMutableArray alloc] init];
             
             landmarkLib = [LandmarkLibrary sharedLibraty];
             _landmarkItems = [landmarkLib allItems];
             oneSecondTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(performBackgroundTask) userInfo:nil repeats:YES];
             
             self.landmarkTableView.dataSource = self;
             self.landmarkTableView.delegate = self;
             self.landmarkTableView.allowsSelectionDuringEditing = true;
             [self.landmarkTableView registerNib:[UINib nibWithNibName:@"LandmarkTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];

         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet connection" message:@"Please connect to internet and try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
             [alert show];
         }
     }];
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
    cell.landmarkName.text = landmarkItem.LandmarkName;
    cell.landmarkCity.text = landmarkItem.City;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toInfoViewSegue"])
    {
        NSIndexPath *indexPath = (NSIndexPath *) sender;
        LandmarkItem *landmarkItem = [_landmarkItems objectAtIndex:[indexPath row]];
        InfoViewController *infoController = segue.destinationViewController;
        infoController.landmarkItem = landmarkItem;
    }
}

-(IBAction)returnToLandmarkController:(UIStoryboardSegue *) segue{
    self.infoViewController = segue.sourceViewController;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: Row: selected and its data is");
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self performSegueWithIdentifier:@"toInfoViewSegue" sender:indexPath];
    
}

- (void)performBackgroundTask
{
    NSLog(@"enter");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if(landmarkLib.allItemsLoaded){
            dispatch_async(dispatch_get_main_queue(), ^{
                [oneSecondTimer invalidate];
                [self.landmarkTableView reloadData];
                [spinner stopAnimating];
            });
        }
    });
}
@end
