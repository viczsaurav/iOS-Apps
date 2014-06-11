//
//  ViewController.h
//  LocateAPlaceEx
//
//  Created by administrator on 2/28/13.
//  Copyright (c) 2013 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotation.h"

@interface ViewController : UIViewController {
  	IBOutlet MKMapView *mapView;
	IBOutlet UITextField *locationTitleField;
	
}


@end
