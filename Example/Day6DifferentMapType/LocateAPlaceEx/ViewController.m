//
//  ViewController.m
//  LocateAPlaceEx
//
//  Created by administrator on 2/28/13.
//  Copyright (c) 2013 administrator. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
-(void) annotateMap: (CLLocationCoordinate2D) newCoordinate {
    
    MapAnnotation *ma = [[MapAnnotation alloc] initWithCoordinate:newCoordinate                                                             title:[locationTitleField text]];
    [mapView addAnnotation:ma];
    [mapView setCenterCoordinate:newCoordinate animated:YES];
    
    
    // structure to define areas spanned by a map region
    MKCoordinateRegion region;
    
    region.center = newCoordinate;
    // define the distance (in degrees) to be display
    region.span.latitudeDelta = .005;
    region.span.longitudeDelta = .005;
    
    [mapView setRegion:region animated:TRUE];
    
    return;
}

-(BOOL)textFieldShouldReturn:(UITextField *)tf
{
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:locationTitleField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
        [self annotateMap:firstPlacemark.location.coordinate];
        
        if (error) {
            NSLog (@"Error: %@", [error description]);
        }
    }];
    
 	[tf resignFirstResponder];
	return YES;
}

- (IBAction)mapSatelliteSegmentControl:(id)sender {
    
    switch (((UISegmentedControl *) sender).selectedSegmentIndex)
    // switch (sender.index)
    {
        case 0: //Satellite
            mapView.mapType = MKMapTypeStandard;
            break;
        case 1: //Satellite
            mapView.mapType = MKMapTypeSatellite;
            break;
        default:  //Map
            mapView.mapType = MKMapTypeHybrid;
            break;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
