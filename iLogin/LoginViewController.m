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
//@synthesize loginModel,userID, password;

@end


@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _loginModel = [[LoginModel alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// My Methods

-(IBAction)login:(id) sender {
    NSString *name = _userID.text;
    NSString *pass = _password.text;
    NSLog(@"Username is %@ and password is %@ ",name,pass);
    BOOL result = [_loginModel verifyUser:name andPassword:pass];
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

@end
