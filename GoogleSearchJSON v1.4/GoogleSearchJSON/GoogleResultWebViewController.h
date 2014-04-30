//
//  WebView.h
//  GoogleSearchJSON
//
//  Created by Saurav on 4/27/14.
//  Copyright 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoogleResultWebViewController : UIViewController <UIWebViewDelegate> {
	UIWebView *webView;
}
@property(strong, nonatomic) IBOutlet UIWebView *webView;
@end
