//
//  ViewController.m
//  DemoLocalNotifications
//
//  Created by Ouh Eng Lieh on 4/1/14.
//  Copyright (c) 2014 Ouh Eng LIeh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	UIDevice *device = [UIDevice currentDevice];
	BOOL result = [device isMultitaskingSupported];
	NSLog(@"Is multitasking supported? %@", (result ? @"YES" : @"NO"));
}

- (void) showAlert:(NSString*)pushmessage
{
	
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Notifications"
                    message:pushmessage
                    delegate:self
                    cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
}
- (IBAction) startTimer {
	newTimer = [NSTimer scheduledTimerWithTimeInterval:5.0
                    target:self
                    selector:@selector(timerAlert:) userInfo:nil repeats:YES];
}
- (IBAction) stopTimer {
	[newTimer invalidate];
}

- (void) timerAlert:(NSTimer *)paramTimer{
	[self showAlert:@"Received timer notifications"];
}
- (IBAction) notify {
	NSLog(@"scheduling notification:");
	UIApplication *app = [UIApplication sharedApplication];
	app.applicationIconBadgeNumber = 0;
	UILocalNotification *notif = [[UILocalNotification alloc] init];
	if (notif) {
		notif.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
		notif.timeZone = [NSTimeZone defaultTimeZone];
		notif.repeatInterval = 0;
		notif.applicationIconBadgeNumber = app.applicationIconBadgeNumber + 1;
		notif.soundName = @"default";
		notif.alertBody = @"Received Local Notification";
		[app scheduleLocalNotification:notif];
	}
    
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"Number of notifs is %d", localNotifications.count);
}

- (IBAction) delayNotify {
	[self performSelector:@selector(showAlert:) withObject:@"Received delay notifications"
			   afterDelay:3.0f];
	
	[window makeKeyAndVisible];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
