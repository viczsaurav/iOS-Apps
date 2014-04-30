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
@property(strong, nonatomic) IBOutlet UIWebView *webView;
@property(strong, nonatomic) SearchResults *searchResults;
@end
