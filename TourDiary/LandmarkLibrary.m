//
//  LandmarkLibrary.m
//  TourDiary
//
//  Created by plamen on 11/10/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "LandmarkLibrary.h"

@interface LandmarkLibrary ()

@property (nonatomic) NSMutableArray *_landmarkItems;

@end

@implementation LandmarkLibrary

static LandmarkLibrary *landmarkLibrary = nil;
NSTimer *oneSecondTimer;
bool itemsLoaded = NO;

+(instancetype) sharedLibraty{
    if(!landmarkLibrary){
        landmarkLibrary = [[self alloc] initPrivate];
    }
    
    return landmarkLibrary;
}

-(instancetype)init{
        @throw [NSException exceptionWithName:@"Singleton"
                                       reason:@"Use +[LandmarkLibrary sharedLibrary]"
                                     userInfo:nil];
        return nil;
}

-(instancetype)initPrivate{
    self = [super init];
    if(self){
        [self setAllItemsLoaded:NO];
    }
    return self;
}

- (NSMutableArray *)allItems
{
    if(!itemsLoaded){
        [self loadItems];
    }
    
    return self._landmarkItems;
}

-(void)loadItems{
    self._landmarkItems = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:[LandmarkItem parseClassName]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (LandmarkItem *object in objects) {
                object.imageLoaded = [NSNumber  numberWithBool:NO];
                [self._landmarkItems addObject:object];
            }
            oneSecondTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(performBackgroundTask) userInfo:nil repeats:YES];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    itemsLoaded = YES;
}

-(void) updateItems{
    [self loadItems];
}

- (void)performBackgroundTask
{
    NSLog(@"enter");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL allImagesLoaded = true;
        for (LandmarkItem *item in self._landmarkItems) {
            item.imageData;
            if(item.imageLoaded.boolValue == NO){
                allImagesLoaded = false;
            }
        }
        if(allImagesLoaded){
            [oneSecondTimer invalidate];
            [self setAllItemsLoaded:YES];
        }
    });
}

@end

