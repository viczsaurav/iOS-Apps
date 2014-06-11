//
//  ControlDemoViewController.h
//  ControlDemo
//
//  Created by Ouh Eng Lieh on 4/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlDemoViewController : UIViewController <UITextFieldDelegate>{
	CGRect labelRect;
	
	UILabel *didEndOnExit;
	UILabel *editingChanged;
	UILabel *editingDidBegin;
	UILabel *editingDidEnd;
	UILabel *valueChanged;
	
	UILabel *touchDownLabel;
	UILabel *touchDownRepeatLabel;
	UILabel *touchDragInsideLabel;
	UILabel *touchDragOutsideLabel;
	UILabel *touchDragEnterLabel;
	UILabel *touchDragExitLabel;
	UILabel *touchUpInsideLabel;
	UILabel *touchUpOutsideLabel;
	UILabel *touchCancelLabel;
	
	UIButton *button;
	UITextField *textField;
	UISlider *slider;
	UISwitch *uiswitch;
	
	

}

@end

