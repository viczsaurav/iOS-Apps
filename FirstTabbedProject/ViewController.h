//
//  ViewController.h
//  SupportEmailCall
//
//  Created by Saurav on 4/20/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate>

- (IBAction) emailSupport;
- (IBAction) callSupport;

@end
