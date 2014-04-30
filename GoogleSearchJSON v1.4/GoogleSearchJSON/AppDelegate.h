//
//  AppDelegate.h
//  GoogleSearchJSON
//
//  Created by Saurav on 4/27/14.
//  Copyright 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchResults;

@interface AppDelegate : NSObject <UIApplicationDelegate, UIToolbarDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) SearchResults *searchResults;

//Selector method for our notifications

-(void) switchWebView;
-(void) switchResultView;

@end
