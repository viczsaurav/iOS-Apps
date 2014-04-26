//
//  ViewController.h
//  LocationManager
//
//  Created by Saurav on 26/4/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController <CLLocationManagerDelegate>
{
    IBOutlet UITextView *textView;
    CLLocationManager *locationManager;
    NSUInteger noUpdates;
}
@end
