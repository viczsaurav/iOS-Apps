//
//  ZZAppDelegate.m
//  PayPal-iOS-SDK-Sample-App
//
//  Copyright (c) 2014, PayPal
//  All rights reserved.
//

#import "ZZAppDelegate.h"
#import "PayPalMobile.h"

@implementation ZZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//warning "Enter your credentials"
  [PayPalMobile initializeWithClientIdsForEnvironments:
  @{PayPalEnvironmentProduction : @"YOUR_CLIENT_ID_FOR_PRODUCTION",
    PayPalEnvironmentSandbox : @"AU5dEBAPrjUdIVycEvN3EsewfeppSIW7bmql_n-uE_UgWEoCLn_qh3lCswNh"}];
  return YES;
}

@end
