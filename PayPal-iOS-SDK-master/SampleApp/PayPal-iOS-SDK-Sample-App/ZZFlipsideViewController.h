//
//  ZZFlipsideViewController.h
//  PayPal-iOS-SDK-Sample-App
//
//  Copyright (c) 2014, PayPal
//  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"

@class ZZFlipsideViewController;

@protocol ZZFlipsideViewControllerDelegate

- (void)flipsideViewControllerDidFinish:(ZZFlipsideViewController *)controller;
- (BOOL)acceptCreditCards;
- (void)setAcceptCreditCards:(BOOL)processCreditCards;

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, strong, readwrite) NSString *resultText;

@end

#pragma mark -

@interface ZZFlipsideViewController : UIViewController

@property(weak, nonatomic) id <ZZFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
