//
//  DemoFlickrViewController.m
//  DemoFlickr
//
//  Created by Ouh Eng Lieh on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DemoFlickrViewController.h"
#import "FlickrTable.h"

@implementation DemoFlickrViewController
@synthesize searchString, flickrController, selectedImage, reselectButton;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadSelectedImage:) name:@"loadSelectedImage" object:nil]; 
}

-(IBAction) submit {
	self.flickrController = [[FlickrTable alloc]init:searchString.text];
	[self presentViewController:flickrController animated:YES completion:nil];
}

-(IBAction) reselect {
	[self presentViewController:flickrController animated:YES completion:nil];
}

-(void) loadSelectedImage:(NSNotification *) notif{
	reselectButton.hidden = NO;
	
	[flickrController dismissViewControllerAnimated:YES completion:nil];
	NSDictionary *dict = [notif userInfo];
	NSData *image = [NSData dataWithContentsOfURL:[dict objectForKey:@"selected"]];
    
	selectedImage.image = [UIImage imageWithData:image];
}

-(IBAction) doneEditing:(id) sender {
	[sender resignFirstResponder];	
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/





/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
