//
//  GoogleResults.h
//  GoogleSearchJSON
//
//  Created by Saurav on 4/27/14.
//  Copyright 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchResults;


@interface GoogleResultsViewController : UITableViewController {
	UITableView *resultView;
}
@property(strong, nonatomic) IBOutlet UITableView *resultView;
@property(strong, nonatomic) SearchResults *searchResults;

@end
