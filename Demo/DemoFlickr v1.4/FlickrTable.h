//
//  FlickrTable.h
//  DemoFlickr
//
//  Created by Ouh Eng Lieh on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FlickrTable : UIViewController <UITableViewDelegate> {
	UITableView *flickrTable;
	NSString *searchString;
	NSMutableArray *photoNames;
    NSMutableArray *photoURLs;
	NSMutableArray *photoSmallURLs;
}
@property (nonatomic, strong) IBOutlet UITableView *flickrTable;
@property (nonatomic, strong) NSString *searchString;
@property (nonatomic, strong) NSMutableArray *photoNames;
@property (nonatomic, strong) NSMutableArray *photoURLs;
@property (nonatomic, strong) NSMutableArray *photoSmallURLs;

- (id) init:(NSString *) str;

@end
