//
//  ViewController.m
//  StockQuoteWS
//
//  Created by Saurav on 4/24/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    bool companyFound;
    bool dateFound;
    bool priceFound;
    bool changeFound;
    bool highFound;
    bool lowFound;
    bool mktcapFound;
    NSURLConnection *conn;
}
@end

@implementation ViewController
@synthesize stockDate, stockLastPrice, stockSymbol, companyName, mktCap, todayHigh, todayLow, change;
@synthesize activityIndicatorView,buffer,parser;

- (IBAction) lookup {
    [stockSymbol resignFirstResponder];
    NSString *symbol = stockSymbol.text;
    NSString *soapRequest = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<GetQuote xmlns=\"http://www.webserviceX.NET/\">"
                             "<symbol>%@</symbol>"
                             "</GetQuote>"
                             "</soap:Body>"
                             "</soap:Envelope>", symbol];
    NSLog(@"SoapRequest is %@",soapRequest);
    NSURL *url = [NSURL URLWithString:@"http://www.webservicex.net/stockquote.asmx"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req addValue:@"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://www.webserviceX.NET/GetQuote" forHTTPHeaderField:@"SOAPAction"];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapRequest length]];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapRequest dataUsingEncoding:NSUTF8StringEncoding]];
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    if (conn) {
        self.buffer =[NSMutableData data];
    }
    [activityIndicatorView startAnimating];
}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
	[buffer setLength:0];
}
-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data {
    NSLog(@"new data: %@",data);
	[buffer appendData:data];
}
-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error {
	[activityIndicatorView stopAnimating];
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
	NSLog(@"Done with bytes %lu",(unsigned long)[buffer length]);
    NSMutableString *theXML = [[NSMutableString alloc] initWithBytes:[buffer mutableBytes]
                                                            length:[buffer length]
                                                            encoding:NSUTF8StringEncoding];
    [theXML replaceOccurrencesOfString:@"&lt;" withString:@"<" options:0 range:NSMakeRange(0, [theXML length])];
    [theXML replaceOccurrencesOfString:@"&gt;" withString:@">" options:0 range:NSMakeRange(0, [theXML length])];
    NSLog(@"Soap Response is %@",theXML);
    [buffer setData:[theXML dataUsingEncoding:NSUTF8StringEncoding]];
    self.parser = [[NSXMLParser alloc] initWithData:buffer];
    [parser setDelegate:self];
    [parser parse];
	[activityIndicatorView stopAnimating];
    
}

-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName
  namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
	if ([elementName isEqualToString:@"Date"]) {
		dateFound = YES;
	} else 	if ([elementName isEqualToString:@"Last"]) {
		priceFound = YES;
	}else 	if ([elementName isEqualToString:@"Name"]) {
		companyFound = YES;
	}else 	if ([elementName isEqualToString:@"Change"]) {
		changeFound = YES;
	}else 	if ([elementName isEqualToString:@"High"]) {
		highFound = YES;
	}else 	if ([elementName isEqualToString:@"Low"]) {
		lowFound = YES;
	}else 	if ([elementName isEqualToString:@"MktCap"]) {
		mktcapFound = YES;
	}
}

- (void) parser:(NSXMLParser *) parser foundCharacters:(NSString *) string {
	if (dateFound) {
		stockDate.text = string;
		dateFound = NO;
	} else if (priceFound) {
		stockLastPrice.text = string;
		priceFound = NO;
	}else if (companyFound) {
		companyName.text = string;
		companyFound = NO;
	}else if (changeFound) {
		change.text = string;
		changeFound = NO;
	}else if (highFound) {
		todayHigh.text = string;
		highFound = NO;
	}else if (lowFound) {
		todayLow.text = string;
		lowFound = NO;
	}else if (mktcapFound) {
		mktCap.text = string;
		mktcapFound = NO;
	}
}

-(void) parser:(NSXMLParser *) parser didEndElement:(NSString *) elementName
  namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
