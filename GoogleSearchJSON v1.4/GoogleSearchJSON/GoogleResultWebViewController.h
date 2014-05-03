//
//  WebView.h
//  GoogleSearchJSON
//
//  Created by Saurav on 4/27/14.
//  Copyright 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchResults;

@interface GoogleResultWebViewController : UIViewController <UIWebViewDelegate> {
	UIWebView *webView;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;
@property(strong, nonatomic) IBOutlet UIWebView *webView;
@property(strong, nonatomic) SearchResults *searchResults;

@property (strong, nonatomic) IBOutlet UITextField *addressField;


@end
