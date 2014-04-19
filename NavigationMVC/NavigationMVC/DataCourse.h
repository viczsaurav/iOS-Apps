//
//  DataCourse.h
//  NavigationMVC
//
//  Created by Saurav on 4/20/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCourse : NSObject {
    NSString *courseID;
    NSString *courseDesc;
    NSString *lecturer;
}

@property (nonatomic, copy) NSString *courseID;
@property (nonatomic, copy) NSString *courseDesc;
@property (nonatomic, copy) NSString *lecturer;

+ (NSMutableArray *) getExistingCourses;
- (id) initWithID: (NSString *) myID;

@end
