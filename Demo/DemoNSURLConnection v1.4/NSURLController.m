//
//  NSURLController.m
//  DemoNetworking
//
//  Created by Ouh Eng Lieh on 5/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSURLController.h"
#import "Reachability.h"

@implementation NSURLController
@synthesize searchString, debug, activityView, buffer;

// Using NSURLConnection for synchronous connection
- (IBAction) syncConnect {
	NSString *urlAsString = [NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?key=AIzaSyAK_OrkVhqpZhOUVKbYGeHaLeRzXZ7-Vrc&cx=013135279617490993477:gil2nfow3x0&q=%@&alt=json",searchString.text];
	NSURL    *url = [NSURL URLWithString:urlAsString];
	NSError *error = nil;
	
	// Create the request to pass to NSURLConnection 
	NSURLRequest *request = [NSURLRequest requestWithURL:url]; 	
	NSHTTPURLResponse   * response;
	
	// Block the current thread with the synchronous connection
	NSMutableData   *data = [[NSURLConnection sendSynchronousRequest:request
												   returningResponse:&response
															   error:&error] mutableCopy];
	if (error != nil) {
		NSLog(@"Error code %d", [error code]);
		NSLog(@"Error description %@", [error localizedDescription]);
		NSLog(@"Error domain %@", [error domain]);
	}
	// Process the data 
	if (data != nil){
		[self processPage:data];
	}
}

// Using NSURLConnection for asynchronous connection with completion handler
- (IBAction) asyncConnectWithCompletionHandler {
	
	[activityView startAnimating];
    self.buffer = [NSMutableData data];

	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?key=AIzaSyAK_OrkVhqpZhOUVKbYGeHaLeRzXZ7-Vrc&cx=013135279617490993477:gil2nfow3x0&q=%@&alt=json",searchString.text]];
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
	[req setHTTPMethod:@"GET"];
	
	[NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error != nil) {
            NSLog(@"Error code %d", [error code]);
            NSLog(@"Error description %@", [error localizedDescription]);
            NSLog(@"Error domain %@", [error domain]);
        }
        // Process the data
        if (data != nil){
            [self processPage:[data mutableCopy]];
        }
    }];
}
// Using NSURLConnection for asynchronous connection with delegate methods
- (void) asyncConnectWithDelegate {
 
	[activityView startAnimating];
    self.buffer = [NSMutableData data];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?key=AIzaSyAK_OrkVhqpZhOUVKbYGeHaLeRzXZ7-Vrc&cx=013135279617490993477:gil2nfow3x0&q=%@&alt=json",searchString.text]];
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
	[req setHTTPMethod:@"GET"];
	
	conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
	NSLog(@"Entering didReceiveResponse");
	[buffer setLength:0];
}
-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data {
	NSLog(@"Entering didReceiveData");
	[buffer appendData:data];
}
-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error {
	NSLog(@"Entering didFailWithError");
	[activityView stopAnimating];
	
	if (error != nil) {
		NSLog(@"Error code %d", [error code]);
		NSLog(@"Error description %@", [error localizedDescription]);
		NSLog(@"Error domain %@", [error domain]);
	}
}
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
	NSLog(@"Entering connectionDidFinishLoading");
	NSLog(@"Done with bytes %d", [buffer length]);
	
	[self processPage:buffer];
	
	[activityView stopAnimating];
	
}

// Using NSURLConnection to POST
- (IBAction) postToPage {
	[activityView startAnimating];	
    self.buffer = [NSMutableData data];

	NSURL *url = [NSURL URLWithString:@"http://ec2-175-41-172-17.ap-southeast-1.compute.amazonaws.com:8080/SecureFormWebApplication/j_security_check"];
	
	NSMutableURLRequest *req =   [NSMutableURLRequest  requestWithURL:url
														  cachePolicy:NSURLRequestUseProtocolCachePolicy
													  timeoutInterval:60.0f];
	[req setHTTPMethod:@"POST"];
	NSString *post = [NSString stringWithFormat:@"j_username=%@&j_password=%@", @"user", @"password"];
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	[req addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[req addValue:@"application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" forHTTPHeaderField:@"Accept"];
	[req addValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
	
	[req setHTTPBody:postData];
	
	conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
}

// Handling Authentication  with delegate methods
- (IBAction) basicAuthConnectSSL {
	[activityView startAnimating];
    self.buffer = [NSMutableData data];

	NSURL *url = [NSURL URLWithString:@"https://ec2-175-41-172-17.ap-southeast-1.compute.amazonaws.com:8181/SecureWebApplication/"];
	NSMutableURLRequest *req =   [NSMutableURLRequest  requestWithURL:url];
	[req setHTTPMethod:@"GET"];
	
	conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"Entering didReceiveAuthenticationChallenge");
	
	NSURLCredential *cred = [[NSURLCredential alloc] initWithUser:@"user"        password:@"password" persistence:NSURLCredentialPersistenceNone];
	[[challenge sender] useCredential:cred forAuthenticationChallenge:challenge];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	NSLog(@"Entering canAuthenticateAgainstProtectionSpace with method %@", protectionSpace.authenticationMethod);
	
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust] || 
	[protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic];
}

// Check for reachability
- (IBAction) reachable {
	Reachability* reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
	NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
	
	if(remoteHostStatus == NotReachable) { debug.text = @"not reachable";}
	else if (remoteHostStatus == ReachableViaWWAN) { debug.text = @"reachable via wwan";}
	else if (remoteHostStatus == ReachableViaWiFi) { debug.text = @"reachable via wifi";}
	
}

// Show the cookies
- (IBAction) showCookies {
	NSArray* all = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];	
	
	// Now we can print all of the cookies we have:	
	for (NSHTTPCookie *cookie in all) {
		NSLog(@"Cookie Name: %@ : Value: %@, Expires: %@, Domain: %@, Path: %@", cookie.name, cookie.value, cookie.expiresDate, cookie.domain, cookie.path); 
		debug.text = [NSString stringWithFormat:@"Cookie Name: %@ : Value: %@, Expires: %@, Domain: %@, Path: %@", cookie.name, cookie.value, cookie.expiresDate, cookie.domain, cookie.path]; 
	}
	
	
}

- (void) processPage: (NSMutableData *) data {
	NSMutableString *page = [[NSMutableString alloc] initWithBytes:[data mutableBytes] length:[data length] encoding:NSUTF8StringEncoding];
	debug.text = page;
	NSLog(@"%@", page);
}

- (IBAction) clearTextView {
	debug.text = @"";
}

-(IBAction) doneEditing:(id) sender {
	[sender resignFirstResponder];	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[debug setFont:[UIFont fontWithName:@"ArialMT" size:12]];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {

}


@end
