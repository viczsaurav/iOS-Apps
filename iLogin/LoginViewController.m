//
//  LoginViewController.m
//  iLogin
//
//  Created by Saurav on 16/4/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginModel.h"

@interface LoginViewController ()

@end


@implementation LoginViewController
@synthesize loginModel,userID, password;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


// This will help dismiss the keyboard when the "Return" button is pressed
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    loginModel = [[LoginModel alloc] init];
    userID.delegate = self;
    password.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// My Methods

-(IBAction)login:(id) sender {
    [userID resignFirstResponder];
    [password resignFirstResponder];
    NSString *name = userID.text;
    NSString *pass = password.text;
    NSLog(@"Username is %@ and password is %@ ",name,pass);
    BOOL result = [loginModel verifyUser:name andPassword:pass];
    if (!result) {
        [self printMessage:@"Incorrect UserID or Password"];
    } else {
        [self printMessage:@"Welcome to the Application"];
    }
    
}

-(void) printMessage:(NSString *)name {
    UIAlertView *alertPopup = [[UIAlertView alloc]
                               initWithTitle:@"Alert"
                               message:name
                               delegate:nil
                               cancelButtonTitle:@"Ok"
                               otherButtonTitles: nil];
    [alertPopup show];
    NSLog(@"The message is for %@",name);
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [userID resignFirstResponder];
    [password resignFirstResponder];
    return YES;
}
@end
