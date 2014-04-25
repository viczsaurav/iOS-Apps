//
//  ViewController.h
//  StockQuoteWS
//
//  Created by Saurav on 4/24/14.
//  Copyright (c) 2014 Ouh Eng LIeh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSXMLParserDelegate>

@property (strong, nonatomic) IBOutlet UILabel *stockDate;
@property (strong, nonatomic) IBOutlet UILabel *stockLastPrice;
@property (strong, nonatomic) IBOutlet UITextField *stockSymbol;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) NSMutableData *buffer;

@property (strong,nonatomic) NSXMLParser *parser;

- (IBAction) lookup;

@end
