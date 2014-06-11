//
//  ControlDemoViewController.m
//  ControlDemo
//
//  Created by Ouh Eng Lieh on 4/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ControlDemoViewController.h"

@implementation ControlDemoViewController

- (UILabel *)addLabelWithText:(NSString *)text {
	UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
	
	label.font = [UIFont boldSystemFontOfSize:12.0];
	label.textColor = [UIColor blueColor];
	label.textAlignment = NSTextAlignmentCenter;
	label.alpha = 0.3;
	label.text = text;
	[self.view addSubview:label];
	
	labelRect.origin.y += labelRect.size.height + 0.3;
	
	return label;
}

- (void)highlightLabel:(UILabel *)label {
	label.alpha = 1.0;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.5];
	label.alpha = 0.3;
	[UIView commitAnimations];
}


- (void) setTarget: (UIControl *) control {
	[control addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
	[control addTarget:self action:@selector(touchDownRepeat) forControlEvents:UIControlEventTouchDownRepeat];
	[control addTarget:self action:@selector(touchDragInside) forControlEvents:UIControlEventTouchDragInside];
	[control addTarget:self action:@selector(touchDragOutside) forControlEvents:UIControlEventTouchDragOutside];
	[control addTarget:self action:@selector(touchDragEnter) forControlEvents:UIControlEventTouchDragEnter];
	[control addTarget:self action:@selector(touchDragExit) forControlEvents:UIControlEventTouchDragExit];
	[control addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
	[control addTarget:self action:@selector(touchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
	[control addTarget:self action:@selector(touchCancel) forControlEvents:UIControlEventTouchCancel];
	
	[control addTarget:self action:@selector(didEndOnExit) forControlEvents:UIControlEventEditingDidEndOnExit];
	[control addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
	[control addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
	[control addTarget:self action:@selector(editingChanged) forControlEvents:UIControlEventEditingChanged];
	[control addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	labelRect = CGRectMake(0.0, 20.0, 320.0, 15.0);
	
	didEndOnExit = [self addLabelWithText:@"Did End On Exit"];
	editingChanged = [self addLabelWithText:@"Editing Changed"];
	editingDidBegin = [self addLabelWithText:@"Editing Did Begin"];
	editingDidEnd = [self addLabelWithText:@"Editing Did End"];
	valueChanged = [self addLabelWithText:@"Value Changed"];
	touchDownLabel = [self addLabelWithText:@"Touch Down"];
	touchDownRepeatLabel = [self addLabelWithText:@"Touch Down Repeat"];
	touchDragInsideLabel = [self addLabelWithText:@"Drag Inside"];
	touchDragOutsideLabel = [self addLabelWithText:@"Drag Outside"];
	touchDragEnterLabel = [self addLabelWithText:@"Drag Enter"];
	touchDragExitLabel = [self addLabelWithText:@"Drag Exit"];
	touchUpInsideLabel = [self addLabelWithText:@"Touch Up Inside"];
	touchUpOutsideLabel = [self addLabelWithText:@"Touch Up Outside"];
	touchCancelLabel = [self addLabelWithText:@"Touch Cancelled"];
	
	CGRect textFieldRect = CGRectMake(50.0,labelRect.origin.y + 10,  220, 25.0);
	textField = [[UITextField  alloc] initWithFrame:textFieldRect];
	textField.text = @"This is a textfield";
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.returnKeyType = UIReturnKeyDone;
	[self.view addSubview:textField];
	[self setTarget:textField];	
	textField.delegate = self;
	
	CGRect buttonRect = CGRectMake(100.0, labelRect.origin.y + 50, 120.0, 50.0);
	button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.frame = buttonRect;
	[button setTitle:@"This is a button" forState:UIControlStateNormal];;
	[self.view addSubview:button];
	[self setTarget:button];
	
	CGRect sliderRect = CGRectMake(100.0, labelRect.origin.y + 100, 120.0, 50.0);
	slider = [[UISlider alloc] initWithFrame:sliderRect];
	[self.view addSubview:slider];
	[self setTarget:slider];
	
	CGRect uiswtichRect = CGRectMake(110.0, labelRect.origin.y + 150, 120.0, 50.0);
	uiswitch = [[UISwitch alloc] initWithFrame:uiswtichRect];
	[self.view addSubview:uiswitch];
	[self setTarget:uiswitch];
}


- (BOOL)textFieldShouldReturn:(UITextField *)txtField
{
	[textField resignFirstResponder];
	return YES;
}

- (void)touchDown { [self highlightLabel:touchDownLabel]; }
- (void)touchDownRepeat { [self highlightLabel:touchDownRepeatLabel]; }
- (void)touchDragInside { [self highlightLabel:touchDragInsideLabel]; }
- (void)touchDragOutside { [self highlightLabel:touchDragOutsideLabel]; }
- (void)touchDragEnter { [self highlightLabel:touchDragEnterLabel]; }
- (void)touchDragExit { [self highlightLabel:touchDragExitLabel]; }
- (void)touchUpInside { [self highlightLabel:touchUpInsideLabel]; }
- (void)touchUpOutside { [self highlightLabel:touchUpOutsideLabel]; }
- (void)touchCancel { [self highlightLabel:touchCancelLabel]; }
- (void)didEndOnExit { [self highlightLabel:didEndOnExit]; }
- (void)editingDidEnd { [self highlightLabel:editingDidEnd]; }
- (void)editingDidBegin { [self highlightLabel:editingDidBegin]; }
- (void)editingChanged { [self highlightLabel:editingChanged]; }
- (void)valueChanged { [self highlightLabel:valueChanged]; }


@end
