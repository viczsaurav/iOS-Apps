
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
#define GROW_ANIMATION_DURATION_SECONDS 0.15    // Determines how fast a piece size grows when it is moved.
#define SHRINK_ANIMATION_DURATION_SECONDS 0.15  // Determines how fast a piece size shrinks when a piece stops moving.

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if ([self.segmentedControl selectedSegmentIndex] == 0) {
        [self.view addGestureRecognizer:self.swipeLeftRecognizer];
    }
    else {
        [self.view removeGestureRecognizer:self.swipeLeftRecognizer];
    }
    // For illustrative purposes, set exclusive touch for the segmented control (see the ReadMe).
    //[self.segmentedControl setExclusiveTouch:YES];

}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)takeLeftSwipeRecognitionEnabledFrom:(UISegmentedControl *)aSegmentedControl {
    
    /*
     Add or remove the left swipe recogniser to or from the view depending on the selection in the segmented control.
     */
    if ([aSegmentedControl selectedSegmentIndex] == 0) {
        [self.view addGestureRecognizer:self.swipeLeftRecognizer];
    }
    else {
        [self.view removeGestureRecognizer:self.swipeLeftRecognizer];
    }
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    // Disallow recognition of tap gestures in the segmented control.
    if ((touch.view == self.segmentedControl|| touch.view == self.firstPieceView) && (gestureRecognizer == self.tapRecognizer)) {
        return NO;
    }
    return YES;
}


#pragma mark -
#pragma mark Responding to gestures

/*
 In response to a tap gesture, show the image view appropriately then make it fade out in place.
 */
- (IBAction)showGestureForTapRecognizer:(UITapGestureRecognizer *)recognizer {
	
	CGPoint location = [recognizer locationInView:self.view];
	[self drawImageForGestureRecognizer:recognizer atPoint:location];
	
	[UIView animateWithDuration:0.5 animations:^{
        self.imageView.alpha = 0.0;
    }];
}


/*
 In response to a swipe gesture, show the image view appropriately then move the image view in the direction of the swipe as it fades out.
 */
- (IBAction)showGestureForSwipeRecognizer:(UISwipeGestureRecognizer *)recognizer {
    
	CGPoint location = [recognizer locationInView:self.view];
	[self drawImageForGestureRecognizer:recognizer atPoint:location];
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        location.x -= 220.0;
    }
    else {
        location.x += 220.0;
    }
    
	[UIView animateWithDuration:0.5 animations:^{
        self.imageView.alpha = 0.0;
        self.imageView.center = location;
    }];
}


/*
 In response to a rotation gesture, show the image view at the rotation given by the recognizer. At the end of the gesture, make the image fade out in place while rotating back to horizontal.
 */
- (IBAction)showGestureForRotationRecognizer:(UIRotationGestureRecognizer *)recognizer {
	
	CGPoint location = [recognizer locationInView:self.view];
    
    CGAffineTransform transform = CGAffineTransformMakeRotation([recognizer rotation]);
    self.imageView.transform = transform;
	[self drawImageForGestureRecognizer:recognizer atPoint:location];
    /*
     If the gesture has ended or is cancelled, begin the animation back to horizontal and fade out.
     */
    if (([recognizer state] == UIGestureRecognizerStateEnded) || ([recognizer state] == UIGestureRecognizerStateCancelled)) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.alpha = 0.0;
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }
}
- (IBAction)showGestureForPinchRecognizer:(UIPinchGestureRecognizer *)recognizer {
	
	CGPoint location = [recognizer locationInView:self.view];
    
    CGAffineTransform transform = CGAffineTransformMakeScale([recognizer scale],[recognizer scale]);
    self.imageView.transform = transform;
	[self drawImageForGestureRecognizer:recognizer atPoint:location];
    /*
     If the gesture has ended or is cancelled, begin the animation back to horizontal and fade out.
     */
    if (([recognizer state] == UIGestureRecognizerStateEnded) || ([recognizer state] == UIGestureRecognizerStateCancelled)) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.alpha = 0.0;
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }
}


#pragma mark -
#pragma mark Drawing the image view

/*
 Set the appropriate image for the image view for the given gesture recognizer, move the image view to the given point, then dispay the image view by setting its alpha to 1.0.
 */
- (void)drawImageForGestureRecognizer:(UIGestureRecognizer *)recognizer atPoint:(CGPoint)centerPoint {
    
	NSString *imageName;
    
    if ([recognizer isMemberOfClass:[UITapGestureRecognizer class]]) {
        imageName = @"tap.png";
    }
    else if ([recognizer isMemberOfClass:[UIRotationGestureRecognizer class]]) {
        imageName = @"rotation.png";
    }
    else if ([recognizer isMemberOfClass:[UIPinchGestureRecognizer class]]) {
        imageName = @"pinch.tiff";
    }
    else if ([recognizer isMemberOfClass:[UISwipeGestureRecognizer class]]) {
        imageName = @"swipe.png";
    }
    
	self.imageView.image = [UIImage imageNamed:imageName];
	self.imageView.center = centerPoint;
	self.imageView.alpha = 1.0;
}


// Handles the start of a touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //self.touchInfoText.text = @"Phase: Touches began";

	for (UITouch *touch in touches) {
        CGPoint position = [touch locationInView:self.view];
    
        if (CGRectContainsPoint([self.firstPieceView frame], position)) {
            //[self animateFirstTouchAtPoint:position forView:self.firstPieceView];
            self.firstPieceView.center = position;

        }
    }
}
// Handles the continuation of a touch.
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint position = [touch locationInView:self.view];
        
        if (CGRectContainsPoint([self.firstPieceView frame], position)) {
            self.firstPieceView.center = position;
        }
    }
}


// Handles the end of a touch event.
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint position = [touch locationInView:self.view];
        
        if (CGRectContainsPoint([self.firstPieceView frame], position)) {
            [self animateView:self.firstPieceView toPosition: position];
        }
    }
}


// Scales up a view slightly which makes the piece slightly larger, as if it is being picked up by the user.
-(void)animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UIImageView *)theView
{
	// Pulse the view by scaling up, then move the view to under the finger.
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
	theView.transform = CGAffineTransformMakeScale(1.2, 1.2);
	[UIView commitAnimations];
}

// Scales down the view and moves it to the new position.
-(void)animateView:(UIView *)theView toPosition:(CGPoint)thePosition
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:SHRINK_ANIMATION_DURATION_SECONDS];
	// Set the center to the final postion
    //NSLog(@"%f %f", thePosition.x, thePosition.y);
	theView.center = thePosition;
	// Set the transform back to the identity, thus undoing the previous scaling effect.
	theView.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.image = [UIImage imageNamed:@"shake.jpg"];
            self.imageView.alpha = 1.0;
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.alpha = 0.0;
        }];
     }
}

@end
