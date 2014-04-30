//
//  SearchResults.h
//  GoogleSearchJSON
//
//  Created by Saurav on 4/27/14.
//  Copyright 2014 NUS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SearchResults : NSObject {
    NSMutableArray *searchLinks;
    NSMutableArray *searchTitles;
	NSString *selectedLink;
}
@property(strong, nonatomic) NSMutableArray *searchLinks;
@property(strong, nonatomic) NSMutableArray *searchTitles;
@property(strong, nonatomic) NSString *selectedLink;

@end
