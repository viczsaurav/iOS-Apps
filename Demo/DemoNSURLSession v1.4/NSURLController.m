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


// Using NSURLSession for asynchronous connection with completion handler
- (IBAction) asyncConnectWithCompletionHandler {
	
	[activityView startAnimating];
    self.buffer = [NSMutableData data];

    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    
    [[session dataTaskWithURL: [NSURL URLWithString: [NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?key=AIzaSyAK_OrkVhqpZhOUVKbYGeHaLeRzXZ7-Vrc&cx=013135279617490993477:gil2nfow3x0&q=%@&alt=json",searchString.text]]
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

            dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"DATA:\n%@\nEND DATA\n", [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding]);
            debug.text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            [activityView stopAnimating];
            });
        }] resume];
}
// Using NSURLSession for asynchronous connection with delegate methods
- (IBAction)asyncConnectWithDelegate{
 
	[activityView startAnimating];
    self.buffer = [NSMutableData data];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];

    [[session dataTaskWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?key=AIzaSyAK_OrkVhqpZhOUVKbYGeHaLeRzXZ7-Vrc&cx=013135279617490993477:gil2nfow3x0&q=%@&alt=json",searchString.text]]] resume];
   
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    //NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"Received String %@",str);
    [buffer appendData:data];
    
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        NSLog(@"Download is Succesfull");
        NSLog(@"Done with bytes %d", [buffer length]);
        
        [self processPage:buffer];
        [activityView stopAnimating];
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}

// Using NSURLSession for asynchronous POST connection
- (IBAction) postToPage {
	[activityView startAnimating];	
    self.buffer = [NSMutableData data];

	NSURL *url = [NSURL URLWithString:@"http://ec2-175-41-172-17.ap-southeast-1.compute.amazonaws.com:8080/SecureFormWebApplication/j_security_check"];
	
	NSMutableURLRequest *req =   [NSMutableURLRequest  requestWithURL:url
        cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
	[req setHTTPMethod:@"POST"];
	NSString *post = [NSString stringWithFormat:@"j_username=%@&j_password=%@", @"user", @"password"];
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	[req addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[req addValue:@"application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" forHTTPHeaderField:@"Accept"];
	[req addValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
	
	[req setHTTPBody:postData];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    [[session dataTaskWithRequest:req] resume];
}

// Using NSURLSession for authentication with delegate methods
- (IBAction) basicAuthConnectSSL {
	[activityView startAnimating];
    self.buffer = [NSMutableData data];

	NSURL *url = [NSURL URLWithString:@"https://ec2-175-41-172-17.ap-southeast-1.compute.amazonaws.com:8181/SecureWebApplication/"];
	NSMutableURLRequest *req =   [NSMutableURLRequest  requestWithURL:url];
	[req setHTTPMethod:@"GET"];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    [[session dataTaskWithURL:url] resume];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
	
    NSLog(@"Entering didReceiveAuthenticationChallenge - %@",[[challenge protectionSpace] authenticationMethod] );
    if ( [[[challenge protectionSpace] authenticationMethod] isEqualToString:NSURLAuthenticationMethodHTTPBasic]) {
        NSURLCredential *cred = [[NSURLCredential alloc] initWithUser:@"user"        password:@"password" persistence:NSURLCredentialPersistenceNone] ;
        
        completionHandler(NSURLSessionAuthChallengeUseCredential,cred);
    } else {
        NSURLCredential *cred = [NSURLCredential credentialForTrust:[[challenge protectionSpace] serverTrust]];
        completionHandler(NSURLSessionAuthChallengeUseCredential,cred);
    }
}

- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    NSLog(@"sent %lld and total is %lld", bytesSent, totalBytesExpectedToSend);
}

// Checking Reachability
- (IBAction) reachable {
	Reachability* reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
	NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
	
	if(remoteHostStatus == NotReachable) { debug.text = @"not reachable";}
	else if (remoteHostStatus == ReachableViaWWAN) { debug.text = @"reachable via wwan";}
	else if (remoteHostStatus == ReachableViaWiFi) { debug.text = @"reachable via wifi";}
	
}

// Accessing Cookies
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
