//
//  ModulesModel.m
//  Modules
//
//  Created by Saurav on 23/4/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "ModulesModel.h"

@implementation ModulesModel
@synthesize arrayData;

- (id) init {
    self = [super init];
    arrayData = [[NSMutableArray alloc] initWithObjects:@"NUS Mtech", @"Wireless and iOS Programming",nil];
    return self;
}

@end

