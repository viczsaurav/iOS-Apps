//
//  ViewController.h
//  DemoLocalNotifications
//
//  Created by Ouh Eng Lieh on 4/1/14.
//  Copyright (c) 2014 Ouh Eng LIeh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController 
{
    UIWindow *window;
	NSTimer *newTimer;
}
- (IBAction) notify;
- (IBAction) delayNotify;
- (IBAction) startTimer;
- (IBAction) stopTimer;
@end
