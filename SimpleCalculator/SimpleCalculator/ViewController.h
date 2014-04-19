//
//  ViewController.h
//  SimpleCalculator
//
//  Created by student on 4/19/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *textFieldPrincipal;
    IBOutlet UITextField *textFieldNumberOfYears;
    IBOutlet UISlider *sliderNUmberOfYears;
    IBOutlet UITextField *textFieldInterestRate;
    IBOutlet UISlider *sliderInterestRate;
    IBOutlet UIButton *buttonCalculate;
    IBOutlet UILabel *labelAmount;
}

- (IBAction) sliderNumberOfYearsChanged: (id) sender;
- (IBAction) sliderInterestRateChanged: (id) sender;
- (IBAction) displayAmount;

@end
