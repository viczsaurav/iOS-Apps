//
//  ViewController.h
//  integratePayPal
//
//  Created by student on 5/6/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"

@interface ViewController : UIViewController <PayPalPaymentDelegate>

@property (nonatomic,strong,readwrite) PayPalConfiguration *payPalConfiguration;


@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UILabel *resultText;

@end
