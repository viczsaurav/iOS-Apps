//
//  ViewController.m
//  LocationManager
//
//  Created by Saurav on 26/4/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [CLLocationManager new];
    [locationManager setDelegate:self];
    [locationManager startUpdatingLocation];
    textView.text = @"Location Manager Start running";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateLocation : (NSString *) locationDesc {
    NSMutableString *newMessage = [[NSMutableString alloc] initWithCapacity:100];
    [newMessage appendString: [NSString stringWithFormat:@"Update # %i\n",noUpdates]];
    [newMessage appendString:locationDesc];
    [newMessage appendString:@"\n"];
    [newMessage appendString:[textView text]];
    textView.text =newMessage;
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    noUpdates++;
    if (noUpdates>50) {
        [locationManager stopUpdatingLocation];
        textView.text = @"Loaction Manager Stop running";
    }
    CLLocation *lastLocation = [locations lastObject];
    [self updateLocation:[lastLocation description]];
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Could not locate location: %@",error);
}



@end
