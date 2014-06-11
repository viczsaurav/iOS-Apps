//
//  ViewController.m
//  DemoSocial
//
//  Created by Ouh Eng Lieh on 10/4/13.
//  Copyright (c) 2013 Ouh Eng LIeh. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController


-(IBAction)facebook:(id)sender{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"Cancelled");
            } else
            {
                NSLog(@"Done");
            }
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        [controller setInitialText:@"Test Post from Ouh Eng Lieh"];
        [controller addURL:[NSURL URLWithString:@"http://www.iss.nus.edu.sg"]];
        [controller addImage:[UIImage imageNamed:@"ISSLogo.jpg"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        NSLog(@"UnAvailable");
    }
}


-(IBAction)twitter:(id)sender{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];

        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"Cancelled");
            } else
            {
                NSLog(@"Done");
            }
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        [controller setInitialText:@"This is a tweet from iOS 6 Social Framework"];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        NSLog(@"UnAvailable");
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
