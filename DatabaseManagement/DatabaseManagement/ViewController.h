//
//  ViewController.h
//  DatabaseManagement
//
//  Created by Saurav on 26/4/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface ViewController : UIViewController
{
    UITextField *name;
    UITextField *address;
    UITextField *phone;
    UILabel *status;
    
    NSString *databasePath;
    
    sqlite3 *contactDB;
    sqlite3_stmt *insertstatement;
    sqlite3_stmt *updatestatement;
    sqlite3_stmt *deletestatement;
    sqlite3_stmt *selectstatement;
}

@property (retain,nonatomic) IBOutlet UITextField *name;
@property (retain,nonatomic) IBOutlet UITextField *address;
@property (retain,nonatomic) IBOutlet UITextField *phone;
@property (retain,nonatomic) IBOutlet UILabel *status;

-(IBAction)createContact;
-(IBAction)findContact;
-(IBAction)updateContact;
-(IBAction)deleteContact;

@end
