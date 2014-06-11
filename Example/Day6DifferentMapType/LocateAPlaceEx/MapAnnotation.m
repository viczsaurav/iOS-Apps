//
//  MapAnnotation.m
//  LocateAPlaceEx
//
//  Created by administrator on 2/28/13.
//  Copyright (c) 2013 administrator. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation 
@synthesize coordinate, title;

-(id) initWithCoordinate: (CLLocationCoordinate2D) c title:(NSString *)t
{
	if (self =[super init]) {
        coordinate =c;
        [self setTitle:t];
    }
	return self;
}


@end
