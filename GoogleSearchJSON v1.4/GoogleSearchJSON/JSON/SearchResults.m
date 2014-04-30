//
//  SearchResults.m
//  GoogleSearchJSON
//
//  Created by Saurav on 4/27/14.
//  Copyright 2014 NUS. All rights reserved.
//

#import "SearchResults.h"


@implementation SearchResults
@synthesize searchLinks, searchTitles, selectedLink;

- (id) init {
	self.searchLinks = [[NSMutableArray alloc] init];
	self.searchTitles = [[NSMutableArray alloc] init];
	self.selectedLink = @"www.google.com";
	return self;
}
@end
