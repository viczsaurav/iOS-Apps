//
//  GoogleResults.h
//  GoogleSearchJSON
//
//  Created by Ouh Eng Lieh on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoogleResultsViewController : UITableViewController {
	UITableView *resultView;
}
@property(strong, nonatomic) IBOutlet UITableView *resultView;

@end
