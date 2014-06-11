//
//  DemoFlickrViewController.h
//  DemoFlickr
//
//  Created by Ouh Eng Lieh on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FlickrTable;

@interface DemoFlickrViewController : UIViewController {
	UITextField *searchString;
	FlickrTable *flickerController;
	UIImageView *selectedImage;
	UIButton *reselectButton;
}

@property (nonatomic, strong) IBOutlet UITextField *searchString;
@property (nonatomic, strong) IBOutlet FlickrTable *flickrController;
@property (nonatomic, strong) IBOutlet UIImageView *selectedImage;
@property (nonatomic, strong) IBOutlet UIButton *reselectButton;

-(IBAction) submit;
-(IBAction) reselect;
-(IBAction) doneEditing:(id) sender;

@end

