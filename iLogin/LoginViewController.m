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
@synthesize loginModel,userID, password;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// My Methods

-(IBAction)login:(id) sender {
    NSString *name = userID.text;
    NSString *pass = password.text;
    
}

@end
