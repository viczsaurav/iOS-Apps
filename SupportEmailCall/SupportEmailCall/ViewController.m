//
//  ViewController.m
//  SupportEmailCall
//
//  Created by Saurav on 4/20/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)emailSupport {
    MFMailComposeViewController *emailViewController = [MFMailComposeViewController new];
    emailViewController.mailComposeDelegate =self;
    [emailViewController setSubject:@"Support Required"];
    [emailViewController setMessageBody:@"Please Advice" isHTML: YES];
    [self presentViewController:emailViewController animated:YES completion:Nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion: nil];
}

- (IBAction)callSupport {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"98765432"]];
    
}
- (void)viewDidLoad0
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
