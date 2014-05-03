//
//  FirstViewController.m
//  GoogleSearchJSON
//
//  Created by Saurav on 4/27/14.
//  Copyright 2014 NUS. All rights reserved.
//

#import "GoogleSearchViewController.h"
#import "SearchResults.h"
#import "Reachability.h"

@implementation GoogleSearchViewController

@synthesize searchString, activityIndicatorView, buffer, searchResults;

- (IBAction) search {
    Reachability *isreachable = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus isnetwork = [isreachable currentReachabilityStatus];
    if ((isnetwork == ReachableViaWiFi) || (isnetwork== ReachableViaWWAN)) {
        NSString *myKey = @"AIzaSyClcCWkl8gXfsPOlKVzICzlt-29Ylh-288";
        NSString *cxValue = @"018003853024400480720:ser6p4utiqq";
        [activityIndicatorView startAnimating];
        self.buffer = [NSMutableData data];
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession
                             sessionWithConfiguration:defaultConfigObject
                             delegate:self
                             delegateQueue:[NSOperationQueue mainQueue]];
        [[session dataTaskWithURL:
          [NSURL URLWithString:
           [NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?key=%@&cx=%@&q=%@&alt=json",myKey,cxValue,searchString.text]
           ]
          ] resume];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection Available. Please check and try again."
                                                       delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
   
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [buffer appendData:data];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        NSLog(@"Download is Succesfull");
        NSLog(@"Done with bytes %d", [buffer length]);
        
        [self processResponse:buffer];
    }
    else
        NSLog(@"Error %@",[error userInfo]);
    [activityIndicatorView stopAnimating];

}

// Custom
- (void) processResponse:(NSMutableData *)data {
	NSError *e = nil;
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers
                                                              error:&e];
    NSArray *items = [results objectForKey:@"items"];
    NSLog(@"Array items : %@",items);
    for (NSDictionary *item in items) {
        //Get title for each photo
        NSString *title = [item   objectForKey:@"title"];
        [self.searchResults.searchTitles addObject:(title.length > 0 ? title :@"Untitled")];
        NSString *link = [item objectForKey:@"link"];
        [self.searchResults.searchLinks addObject:link];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchResultView" object:nil];
        
    }
    
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


@end
