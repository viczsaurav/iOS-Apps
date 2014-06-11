//
//  ViewController.m
//  DemoView
//
//  Created by Ouh Eng Lieh on 10/4/13.
//  Copyright (c) 2013 Ouh Eng LIeh. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void) loadView {
	[super loadView];
	NSLog(@"loadView");
	
	//---create a Label view--
	CGRect frame = CGRectMake(10, 50, 300, 20) ;
    UILabel *label = [[UILabel alloc] initWithFrame:frame] ;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor] ;
    label.font = [UIFont fontWithName: @"Arial" size: 20] ;
    label.text = @"This is a label from loadView" ;
    label.tag = 1000;
	[self.view addSubview:label];
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"viewDidLoad");
	//---create a Label view--
	CGRect frame = CGRectMake(10, 100, 300, 20) ;
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor] ;
    label.font = [UIFont fontWithName: @"Arial" size: 20] ;
    label.text = @"This is a label from viewDidLoad" ;
    label.tag = 1000;
	[self.view addSubview:label];
	
	frame = CGRectMake(10, 150, 300, 20);    	UIButton *actionButton = [UIButton 		                 buttonWithType:UIButtonTypeRoundedRect] ;    	actionButton.frame = frame;
	[actionButton setTitle:@"This is a button from viewDidLoad!" forState:UIControlStateNormal] ;
	actionButton.backgroundColor = [UIColor clearColor] ;
	actionButton.tag = 2000;
	[actionButton addTarget: self action: @selector(buttonClickedAction: )              forControlEvents: UIControlEventTouchUpInside] ;
	[self.view addSubview:actionButton];
}

- (IBAction) buttonClickedAction: (id) sender {		NSLog(@"buttonClickedAction");
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


@end
