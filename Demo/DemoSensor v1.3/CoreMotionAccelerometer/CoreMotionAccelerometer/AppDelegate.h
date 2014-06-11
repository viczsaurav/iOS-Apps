//
//  AppDelegate.h
//  CoreMotionAccelerometer
//
//  Created by John Morrison on 11/13/12.
//  Copyright (c) 2012 CapTech Consulting Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreMotion/CoreMotion.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    CMMotionManager *motionManager;
    
}

@property (readonly) CMMotionManager *motionManager;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
