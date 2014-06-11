/*
 File: MainViewController.m
 Abstract: Responsible for all UI interactions with the user and the accelerometer
 Version: 2.5
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import "MainViewController.h"
#import "GraphView.h"
#import "AccelerometerFilter.h"

#define kUpdateFrequency	60.0
#define kLocalizedPause		NSLocalizedString(@"Pause","pause taking samples")
#define kLocalizedResume	NSLocalizedString(@"Resume","resume taking samples")

@interface MainViewController()
// Sets up a new filter. Since the filter's class matters and not a particular instance
// we just pass in the class and -changeFilter: will setup the proper filter.
-(void)changeFilter:(Class)filterClass;

@end

@implementation MainViewController

@synthesize unfiltered, filtered, pause, filterLabel,start,stepsLabel,direction,intervals,bpm;

// Implement viewDidLoad to do additional setup after loading the view.
-(void)viewDidLoad
{
	[super viewDidLoad];
	pause.possibleTitles = [NSSet setWithObjects:kLocalizedPause, kLocalizedResume, nil];
	isPaused = NO;
	useAdaptive = NO;
	[self changeFilter:[LowpassFilter class]];
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0 / kUpdateFrequency];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
	
	[unfiltered setIsAccessibilityElement:YES];
	[unfiltered setAccessibilityLabel:NSLocalizedString(@"unfilteredGraph", @"")];
    
	[filtered setIsAccessibilityElement:YES];
	[filtered setAccessibilityLabel:NSLocalizedString(@"filteredGraph", @"")];
    
    self.start = [NSDate date];
    intervals = [[NSMutableArray alloc] initWithCapacity:10];
}

-(void)viewDidUnload
{
	[super viewDidUnload];
	self.unfiltered = nil;
	self.filtered = nil;
	self.pause = nil;
	self.filterLabel = nil;
}

// UIAccelerometerDelegate method, called when the device accelerates.
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    
    float kFilteringFactor=0.1;
    float accelX =0;
    float accelY =0;
    float accelZ =0;
    accelX = ((acceleration.x * kFilteringFactor) + (accelX * (1-kFilteringFactor)));
    accelY = ((acceleration.y * kFilteringFactor) + (accelY * (1-kFilteringFactor)));
    accelZ = ((acceleration.y * kFilteringFactor) + (accelZ * (1-kFilteringFactor)));
    float moveX = acceleration.x - accelX;
    float moveY = acceleration.y - accelY;
    float moveZ = acceleration.z - accelZ;
    float moveVector=0;
    NSString *moveDir = nil;
///////////////
    float low = atan2(moveY,moveX);
    //float low = sqrt(acceleration.x*acceleration.x+acceleration.y*acceleration.y+ acceleration.z*acceleration.z);
    NSTimeInterval timeInterval = fabs([start timeIntervalSinceNow]);
    //NSTimeInterval currentInterval = acceleration.timestamp;
    //NSLog(@"%f", timeInterval);
    
    if ( low < 0 && lastLow > 0 && timeInterval > 0.2 && (fabs(moveX) >= 0.3 || fabs(moveY) >= 0.3 || fabs(moveZ) >= 0.3)) {
    //if ( low < 0 && lastLow > 0 && (currentInterval-timeInterval) > 0.1 && (fabs(moveX) >= 0.3 || fabs(moveY) >= 0.3 || fabs(moveZ) >= 0.3)) {

        NSLog(@"step %d, %f vs %f with time %f", steps++, low, lastLow,timeInterval);
        stepsLabel.text = [NSString stringWithFormat:@"%d", steps];
        self.start = [NSDate date];
        //timeInterval = currentInterval;
        if (steps <= 10) {
            [intervals addObject:[NSNumber numberWithDouble:timeInterval]];
        }
        
        if (steps > 10) {
            [intervals replaceObjectAtIndex:(steps % 10) withObject:[NSNumber numberWithDouble:timeInterval]];
            
            NSTimeInterval total = 0;
            for (int i = 0; i<10; i++) {
                total += [[intervals objectAtIndex:i] doubleValue];
            }
            double value = 60/(total/10);
            NSLog(@"BPM is %f", value);
            [bpm setText:[NSString stringWithFormat:@"%.0f",value]];
        }
    }
    if ( low > 0 && lastLow < 0 && timeInterval > 0.2 && (fabs(moveX) >= 0.3 || fabs(moveY) >= 0.3 || fabs(moveZ) >= 0.3)) {
    //if ( low > 0 && lastLow < 0 && (currentInterval-timeInterval) > 0.1 && (fabs(moveX) >= 0.3 || fabs(moveY) >= 0.3 || fabs(moveZ) >= 0.3)) {
        NSLog(@"steps %d, %f vs %f with time %f", steps++, low, lastLow,timeInterval);
        stepsLabel.text = [NSString stringWithFormat:@"%d", steps];
        self.start = [NSDate date];
        //timeInterval = currentInterval;
        if (steps <= 10) {
            [intervals addObject:[NSNumber numberWithDouble:timeInterval]];
        }
        
        if (steps > 10) {
            [intervals replaceObjectAtIndex:(steps % 10) withObject:[NSNumber numberWithDouble:timeInterval]];
            
            NSTimeInterval total = 0;
            for (int i = 0; i<10; i++) {
                total += [[intervals objectAtIndex:i] doubleValue];
            }
            double value = 60/(total/10);
            NSLog(@"BPM is %f", value);
            [bpm setText:[NSString stringWithFormat:@"%.0f",value]];
        }
    }
	lastLow = low;
    
////////////////////
    
    if (!starttime) {
        starttime = acceleration.timestamp;
    }
    
    if (acceleration.timestamp > starttime + 1 && (fabs(moveX) >= 0.3 || fabs(moveY) >= 0.3 || fabs(moveZ) >= 0.3)) {
        if (fabs(moveX) > fabs(moveVector)) {
            moveVector = moveX;
            moveDir = (moveVector > 0 ? @"Right":@"Left");
        }
        if (fabs(moveY) > fabs(moveVector)) {
            moveVector = moveY;
            moveDir = (moveVector > 0 ? @"Up":@"Down");
        }
        if (fabs(moveZ) > fabs(moveVector)) {
            moveVector = moveZ;
            moveDir = (moveVector > 0 ? @"Forward":@"Backward");
        }
        lasttime = acceleration.timestamp;
        //NSLog(@"test2 %f", lasttime);

    } else if (moveVector && acceleration.timestamp > lasttime+.1) {
        NSLog(@"test %@", [moveDir stringByAppendingFormat:@": %f.", moveVector]);
        direction.text = [moveDir stringByAppendingFormat:@": %f.", moveVector];
        moveDir = [NSString string];
        moveVector = 0;
    }
    //NSLog(@"%@ %f",moveDir, acceleration.timestamp);
    //NSLog(@"test2 %f %f %f %f", moveVector, acceleration.timestamp,lasttime,starttime);
	// Update the accelerometer graph view
	if(!isPaused)
	{
		[filter addAcceleration:acceleration];
		[unfiltered addX:acceleration.x y:acceleration.y z:acceleration.z];
		[filtered addX:filter.x y:filter.y z:filter.z];
	}
}

-(void)changeFilter:(Class)filterClass
{
	// Ensure that the new filter class is different from the current one...
	if(filterClass != [filter class])
	{
		// And if it is, release the old one and create a new one.
		[filter release];
		filter = [[filterClass alloc] initWithSampleRate:kUpdateFrequency cutoffFrequency:5.0];
		// Set the adaptive flag
		filter.adaptive = useAdaptive;
		// And update the filterLabel with the new filter name.
		filterLabel.text = filter.name;
	}
}

-(IBAction)pauseOrResume:(id)sender
{
	if(isPaused)
	{
		// If we're paused, then resume and set the title to "Pause"
		isPaused = NO;
		pause.title = kLocalizedPause;
	}
	else
	{
		// If we are not paused, then pause and set the title to "Resume"
		isPaused = YES;
		pause.title = kLocalizedResume;
	}
	
	// Inform accessibility clients that the pause/resume button has changed.
	UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
}

-(IBAction)filterSelect:(id)sender
{
	if([sender selectedSegmentIndex] == 0)
	{
		// Index 0 of the segment selects the lowpass filter
		[self changeFilter:[LowpassFilter class]];
	}
	else
	{
		// Index 1 of the segment selects the highpass filter
		[self changeFilter:[HighpassFilter class]];
	}
    
	// Inform accessibility clients that the filter has changed.
	UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
}

-(IBAction)adaptiveSelect:(id)sender
{
	// Index 1 is to use the adaptive filter, so if selected then set useAdaptive appropriately
	useAdaptive = [sender selectedSegmentIndex] == 1;
	// and update our filter and filterLabel
	filter.adaptive = useAdaptive;
	filterLabel.text = filter.name;
	
	// Inform accessibility clients that the adaptive selection has changed.
	UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
}

-(void)dealloc
{
	// clean up everything.
	[unfiltered release];
	[filtered release];
	[filterLabel release];
	[pause release];
	[super dealloc];
}

@end
