//
//  FirstViewController.h
//  GoogleSearchJSON
//
//  Created by Saurav on 4/27/14.
//  Copyright 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoogleSearchViewController : UIViewController <NSURLSessionDataDelegate>{
	UITextField *searchString;
	UIActivityIndicatorView *activityIndicatorView;
    NSMutableData *buffer;
	NSURLConnection *conn;
}
@property(strong, nonatomic) IBOutlet UITextField *searchString;
@property(strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property(strong, nonatomic) NSMutableData *buffer;

- (IBAction) search;
- (void) processResponse:(NSMutableData *) data;

@end
