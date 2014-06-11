//
//  ViewController.h
//  CoreMotionAccelerometer
//
//  Created by John Morrison on 11/13/12.
//  Copyright (c) 2012 CapTech Consulting Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (readonly) BOOL accelerometerAvailable;

@property (readonly) BOOL gyroAvailable;

@property (readonly) BOOL deviceMotionAvailable;

@property (strong, nonatomic) IBOutlet UIView *movingView;

@end
