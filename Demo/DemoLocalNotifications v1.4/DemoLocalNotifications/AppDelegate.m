//
//  AppDelegate.m
//  DemoLocalNotifications
//
//  Created by Ouh Eng Lieh on 4/1/14.
//  Copyright (c) 2014 Ouh Eng LIeh. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	NSLog(@"Application entered background state.");
    
	bgTask = [application beginBackgroundTaskWithExpirationHandler: ^{
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
	}];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSLog(@"Application entered background execution.");
		
		if ([application backgroundTimeRemaining] > 1.0) {
			UILocalNotification *notif = [[UILocalNotification alloc] init];
			if (notif) {
				notif.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
				notif.timeZone = [NSTimeZone defaultTimeZone];
				notif.repeatInterval = 0;
				notif.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1;
				notif.soundName = @"default";
				notif.alertBody = @"Received background Notification";
				[application scheduleLocalNotification:notif];
			}
		}
		[application endBackgroundTask:bgTask];
		bgTask = UIBackgroundTaskInvalid;
	});
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notif {
	NSLog(@"application: didReceiveLocalNotification:");
	[self showAlert:notif.alertBody];
	NSLog(@"current notification is %@",notif);
	application.applicationIconBadgeNumber = notif.applicationIconBadgeNumber-1;
	[application cancelLocalNotification:notif];
}

- (void) showAlert:(NSString*)pushmessage
{
	
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Notifications"
                    message:pushmessage
                    delegate:self
                    cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
