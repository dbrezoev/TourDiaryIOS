//
//  CustomTableViewCell.m
//  TourDiary
//
//  Created by admin on 11/2/14.
//  Copyright (c) 2014 brezoev. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell{
    CGPoint _originalCenter;
    BOOL _deleteOnDragRelease;
    BOOL _markDoneOnDragRelease;
    UILabel* _deleteLabel;
}

const float DELETE_LABEL_MARGIN = 10.0f;
const float DELETE_LABEL_WIDTH = 50.0f;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        _deleteLabel = [self createLabel];
        _deleteLabel.text = @"\u2717";
        _deleteLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_deleteLabel];
        
        UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        recognizer.delegate = self;
        [self addGestureRecognizer:recognizer];
        
        UILongPressGestureRecognizer* recognizerL = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        recognizerL.minimumPressDuration = 2.0f;
        [self addGestureRecognizer:recognizerL];
        
        UITapGestureRecognizer* doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTapGestureRecognizer.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTapGestureRecognizer];
    }
    
    return self;
}

-(UILabel*) createLabel {
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectNull];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:32.0];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    _deleteLabel.frame = CGRectMake(self.bounds.size.width + DELETE_LABEL_MARGIN, 0,
                                    DELETE_LABEL_WIDTH, self.bounds.size.height);
}

#pragma mark - GesturesHandling
-(void)handleDoubleTap:(UITapGestureRecognizer*)sender{
    NSLog(@"DOUBLE TAPPPPPPPPPPPPPPPPPPPPP");
    [self.updater update:self.todoItem];
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // if the gesture has just started, record the current centre location
        _originalCenter = self.center;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        // translate the center
        CGPoint translation = [recognizer translationInView:self];
        self.center = CGPointMake(_originalCenter.x + translation.x, _originalCenter.y);
        // determine whether the item has been dragged far enough to initiate a delete / complete
        _deleteOnDragRelease = self.frame.origin.x < -self.frame.size.width / 2;
        _markDoneOnDragRelease = self.frame.origin.x > self.frame.size.width / 2;
        
        float cueAlpha = fabsf(self.frame.origin.x) / (self.frame.size.width / 2);
        _deleteLabel.alpha = cueAlpha;
        _deleteLabel.textColor = _deleteOnDragRelease ?
        [UIColor redColor] : [UIColor whiteColor];
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        // the frame this cell had before drag
        CGRect originalFrame = CGRectMake(0, self.frame.origin.y,
                                          self.bounds.size.width, self.bounds.size.height);
        if (!_deleteOnDragRelease) {
            // if the item is not being deleted, snap back to the original location
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.frame = originalFrame;
                             }
             ];
        }
        
        if (_deleteOnDragRelease) {
            [self.delegate deleteItem:self.todoItem];
        }
        if (_markDoneOnDragRelease) {
            self.todoItem.completed = 0;
            //self.textLabel.backgroundColor = [UIColor greenColor];
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"MESSAGE" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alert show];
            
        }
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer*)sender{
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
    }
    else if (sender.state == UIGestureRecognizerStateBegan){
        NSLog(@"UIGestureRecognizerStateBegan.");
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"MESSAGE" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//        [alert show];
        
        
        NSDateFormatter *gmtFormatter=[[NSDateFormatter alloc] init];
        [gmtFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
        NSString *gmtDateTime=[gmtFormatter stringFromDate:self.todoItem.dateCreated];

        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Note info" message:[NSString stringWithFormat:@"This note was created on:\n %@", gmtDateTime]  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSString* input = [[alertView textFieldAtIndex:0] text];
//    
//    ToDoItem* item = [[ToDoItem alloc] initWithContent:input];
//    [self.delegate addItem:item];
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end