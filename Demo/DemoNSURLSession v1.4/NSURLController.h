//
//  NSURLController.h
//  DemoNetworking
//
//  Created by Ouh Eng Lieh on 5/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSURLController : UIViewController <NSURLSessionDataDelegate> {
	UITextField *searchString;
	UITextView *debug;
	UIActivityIndicatorView *activityView;
	
	NSMutableData *buffer;
}
@property (nonatomic, retain) IBOutlet UITextField *searchString;
@property (nonatomic, retain) IBOutlet UITextView *debug;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property(nonatomic, retain) NSMutableData *buffer;

- (IBAction) asyncConnectWithCompletionHandler;
- (IBAction) asyncConnectWithDelegate;
- (IBAction) showCookies;
- (IBAction) basicAuthConnectSSL;
- (IBAction) clearTextView;
- (IBAction) postToPage;
- (IBAction) reachable;
- (IBAction) doneEditing:(id) sender;

- (void) processPage:(NSMutableData *)data;

@end
