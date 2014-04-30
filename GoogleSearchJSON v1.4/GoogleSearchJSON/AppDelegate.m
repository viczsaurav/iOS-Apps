//
//  AppDelegate.m
//  GoogleSearchJSON
//
//  Created by Saurav on 4/27/14.
//  Copyright 2014 NUS. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchResults.h"
#import "GoogleResultsViewController.h"
#import "GoogleResultWebViewController.h"
#import "GoogleSearchViewController.h"

@implementation AppDelegate
@synthesize searchResults;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.searchResults = [SearchResults new];
    UITabBarController *tb = (UITabBarController *) self.window.rootViewController;
    
    GoogleSearchViewController *toViewController0 = [tb.viewControllers objectAtIndex:0];
    toViewController0.searchResults = self.searchResults;
    
    GoogleResultsViewController *toViewController1 =[[[tb.viewControllers objectAtIndex:1]
                                                      childViewControllers] objectAtIndex:0];
    toViewController1.searchResults = self.searchResults;
    
    GoogleResultWebViewController *toViewController2 = [tb.viewControllers objectAtIndex:2];
    toViewController2.searchResults = self.searchResults;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(switchWebView)
                                                 name:@"SwitchWebView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(switchResultView)
                                                 name:@"SwitchResultView" object:nil];
    return YES;
}

- (void) switchWebView {
    UITabBarController *tb = (UITabBarController *)self.window.rootViewController;
    UIView *fromView = tb.selectedViewController.view;
    UIView *toView = [[tb.viewControllers objectAtIndex:2] view];
    
    //Transition using Page curl
    [UIView transitionFromView:fromView
                        toView:toView duration:0.5
                       options:(2 > tb.selectedIndex?
                                UIViewAnimationOptionTransitionCurlUp :
                                UIViewAnimationOptionTransitionCurlDown)
                    completion:^(BOOL finished){
                        if (finished) {
                            tb.selectedIndex =2;
                        }
                    }
     ];
}

-(void) switchResultView {
    UITabBarController *tb = (UITabBarController *)self.window.rootViewController;
    UIView *fromView = tb.selectedViewController.view;
    UIView *toView = [[tb.viewControllers objectAtIndex:1] view];
    
    //Transitioning using a Page curl
    [UIView transitionFromView:fromView
                        toView:toView duration:0.5
                       options:(1 > tb.selectedIndex?
                                UIViewAnimationOptionTransitionCurlUp :
                                UIViewAnimationOptionTransitionCurlDown)
                    completion:^(BOOL finished){
                        if (finished) {
                            tb.selectedIndex =1;
                        }
                    }
     ];

    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
