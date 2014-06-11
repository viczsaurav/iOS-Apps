//
//  MapAnnotation.h
//  LocateAPlaceEx
//
//  Created by administrator on 2/28/13.
//  Copyright (c) 2013 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation> {
	NSString *title;
	CLLocationCoordinate2D coordinate;
    
}

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

-(id) initWithCoordinate: (CLLocationCoordinate2D)c
				   title:(NSString *)t;


@end
