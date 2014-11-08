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
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
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

#pragma mark - GestureHandling
-(void)handleDoubleTap:(UITapGestureRecognizer*)sender{
    NSLog(@"Double tapped");
    [self.delegate update:self.todoItem];
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
    NSLog(@"handle pan");
    
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
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"MESSAGE" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString* input = [[alertView textFieldAtIndex:0] text];
    
    ToDoItem* item = [[ToDoItem alloc] initWithContent:input];
    [self.delegate addItem:item];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end