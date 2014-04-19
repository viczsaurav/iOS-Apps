//
//  DataCourse.m
//  NavigationMVC
//
//  Created by Saurav on 4/20/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

#import "DataCourse.h"

@implementation DataCourse
@synthesize courseID, courseDesc, lecturer;

+ (NSMutableArray *) getExistingCourses {
    NSMutableArray *courses = [NSMutableArray new];
    
    [courses addObject:[[DataCourse alloc] initWithID:@"iOS Programming"]];
    [courses addObject:[[DataCourse alloc] initWithID:@"Java Programming"]];
    [courses addObject:[[DataCourse alloc] initWithID:@"Android Programming"]];
    [courses addObject:[[DataCourse alloc] initWithID:@"Python Course"]];
    [courses addObject:[[DataCourse alloc] initWithID:@"Agile Development Methodology"]];
    
    return courses;
}

- (id) initWithID:(NSString *)myID {
    self = [super init];
    if (self) {
        self.courseID =myID;
        return self;
    }
    return self;
}

@end
