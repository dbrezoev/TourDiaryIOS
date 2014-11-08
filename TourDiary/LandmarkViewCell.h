//
//  LandmarkViewCell.h
//  TourDiary
//
//  Created by plamen on 11/6/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandmarkViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *landmarkImage;
@property (weak, nonatomic) IBOutlet UILabel *landmarkName;
@property (weak, nonatomic) IBOutlet UILabel *landmarkCity;
@property NSInteger cellIndex;

@end
