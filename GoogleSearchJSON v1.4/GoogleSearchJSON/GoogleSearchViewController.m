//
//  FirstViewController.m
//  GoogleSearchJSON
//
//  Created by Ouh Eng Lieh on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GoogleSearchViewController.h"

@implementation GoogleSearchViewController

@synthesize searchString, activityIndicatorView, buffer;

- (IBAction) search {
    NSString *myKey = @"AIzaSyClcCWkl8gXfsPOlKVzICzlt-29Ylh-288";
    NSString *cxValue = @"018003853024400480720:ser6p4utiqq";
    [activityIndicatorView startAnimating];
    self.buffer = [NSMutableData data];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession
                             sessionWithConfiguration:defaultConfigObject
                             delegate:self
                             delegateQueue:[NSOperationQueue mainQueue]];
    [[session dataTaskWithURL:[NSURL URLWithString:
                               [NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?key=%@&cx=%@&q=%@&alt=json",myKey,cxValue,searchString.text]]] resume];
   
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

- (void) processResponse:(NSMutableData *)data {
	
    
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
