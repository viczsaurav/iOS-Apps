//
//  DetailViewController.h
//  NavigationMVC
//
//  Created by Saurav on 4/20/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataCourse;

@interface DetailViewController : UIViewController {
    IBOutlet UITextField *idField;
    IBOutlet UITextField *descField;
    IBOutlet UITextField *lecturerField;
    DataCourse *editingCourse;
}

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UITextField *idField;
@property (weak, nonatomic) IBOutlet UITextField *descField;
@property (weak, nonatomic) IBOutlet UITextField *lecturerField;
@property (nonatomic, assign) DataCourse *editingCourse;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
