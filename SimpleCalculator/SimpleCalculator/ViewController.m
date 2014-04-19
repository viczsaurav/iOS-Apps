//
//  ViewController.m
//  SimpleCalculator
//
//  Created by student on 4/19/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    textFieldPrincipal.text = @"10000";
    textFieldNumberOfYears.text = [NSString stringWithFormat:@"%d", (int)sliderNUmberOfYears.value];
    textFieldInterestRate.text = [NSString stringWithFormat:@"%.02f",sliderInterestRate.value];
       
    textFieldPrincipal.delegate = self;
    textFieldNumberOfYears.delegate = self;
    textFieldInterestRate.delegate = self;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textFieldPrincipal resignFirstResponder];
    [textFieldNumberOfYears resignFirstResponder];
    [textFieldInterestRate resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//My Methods
//Change With NUmber of Years Changed

- (IBAction)sliderNumberOfYearsChanged:(id)sender {
    int myNewValue = sliderNUmberOfYears.value;
    textFieldNumberOfYears.text = [NSString stringWithFormat:@"%d",myNewValue];
    [self displayAmount];
}

- (IBAction)sliderInterestRateChanged:(id)sender {
    float myNewValue = sliderInterestRate.value;
    textFieldInterestRate.text = [NSString stringWithFormat:@"%.02f",myNewValue];
    [self displayAmount];
}

- (IBAction) displayAmount {
    // Making Keyboard to go away
    [textFieldPrincipal resignFirstResponder];
    [textFieldNumberOfYears resignFirstResponder];
    [textFieldInterestRate resignFirstResponder];
    
    float principalAmount = textFieldPrincipal.text.floatValue;
    int numberOfYears = textFieldNumberOfYears.text.intValue;
    float interestRate = textFieldInterestRate.text.floatValue/100;
    float finalAmount = principalAmount * pow((1+ interestRate), numberOfYears);
    NSLog(@"%.02f",finalAmount);
    labelAmount.text = [NSString stringWithFormat:@"%.02f",finalAmount];
    [textFieldPrincipal resignFirstResponder];
}

@end
