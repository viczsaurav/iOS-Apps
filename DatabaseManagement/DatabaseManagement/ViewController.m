//
//  ViewController.m
//  DatabaseManagement
//
//  Created by Saurav on 26/4/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize name,address,phone,status;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *docsDir;
    docsDir =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"contacts.sqlite"]];
    const char *dbPath = [databasePath UTF8String];
    
    if (sqlite3_open(dbPath, &contactDB) == SQLITE_OK) {
        char *errmsg;
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)";
        if (sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errmsg) != SQLITE_OK) {
            status.text = @"Failed to create table";
        }
    } else {
        status.text = @"Failed to open/create database";
    }
    [self prepareStatement];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// SQL prepare statements

-(void) prepareStatement{
    NSString *sqlstring;
    const char *sql_stmt;
    
    //Prepare INSERT sql statement
    sqlstring = [NSString stringWithFormat:@"INSERT INTO CONTACTS (name, address,phone) VALUES (?,?,?)"];
    sql_stmt =[sqlstring UTF8String];
    sqlite3_prepare_v2(contactDB, sql_stmt, -1, &insertstatement, NULL);
    
    //Prepare UPDATE sql statement
    sqlstring = [NSString stringWithFormat:@"UPDATE CONTACTS SET address =?,phone =? WHERE name = ?"];
    sql_stmt =[sqlstring UTF8String];
    sqlite3_prepare_v2(contactDB, sql_stmt, -1, &updatestatement, NULL);
    
    //Prepare DELETE sql statement
    sqlstring = [NSString stringWithFormat:@"DELETE FROM CONTACTS WHERE name = ?"];
    sql_stmt =[sqlstring UTF8String];
    sqlite3_prepare_v2(contactDB, sql_stmt, -1, &deletestatement, NULL);
    
    //Prepare SELECT/FIND sql statement
    sqlstring = [NSString stringWithFormat:@"SELECT address,phone FROM CONTACTS WHERE name = ?"];
    sql_stmt =[sqlstring UTF8String];
    sqlite3_prepare_v2(contactDB, sql_stmt, -1, &selectstatement, NULL);
    
}

- (void) createContact {
    sqlite3_bind_text(insertstatement, 1, [name.text UTF8String],    -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertstatement, 2, [address.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertstatement, 3, [phone.text UTF8String],   -1, SQLITE_TRANSIENT);
    
    if (sqlite3_step(insertstatement) == SQLITE_DONE) {
        status.text  = @"Contact Added Successfully";
        name.text    = @"";
        address.text = @"";
        phone.text   = @"";
    } else {
        NSLog(@"%s",sqlite3_errmsg(contactDB));
        status.text = @"Failed to add Contact";
    }
    sqlite3_reset(insertstatement);
    sqlite3_clear_bindings(insertstatement);
}

- (void) updateContact {
    sqlite3_bind_text(updatestatement, 1, [address.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(updatestatement, 2, [phone.text UTF8String],   -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(updatestatement, 3, [name.text UTF8String],    -1, SQLITE_TRANSIENT);
    
    if (sqlite3_step(updatestatement) == SQLITE_DONE) {
        status.text  = @"Contact Updated Successfully";
        name.text    = @"";
        address.text = @"";
        phone.text   = @"";
    } else {
        NSLog(@"%s",sqlite3_errmsg(contactDB));
        status.text = @"Failed to update Contact";
    }
    sqlite3_reset(updatestatement);
    sqlite3_clear_bindings(updatestatement);
}

- (void) deleteContact {
    sqlite3_bind_text(deletestatement, 1, [name.text UTF8String],    -1, SQLITE_TRANSIENT);
    
    if (sqlite3_step(deletestatement) == SQLITE_DONE) {
        status.text  = @"Contact Deleted Successfully";
        name.text    = @"";
        address.text = @"";
        phone.text   = @"";
    } else {
        NSLog(@"%s",sqlite3_errmsg(contactDB));
        status.text = @"Failed to delete Contact";
    }
    sqlite3_reset(deletestatement);
    sqlite3_clear_bindings(deletestatement);
}

- (void) findContact {
    sqlite3_bind_text(selectstatement, 1, [name.text UTF8String],    -1, SQLITE_TRANSIENT);
    
    if (sqlite3_step(selectstatement) == SQLITE_ROW) {
        NSString *address_field = [[NSString alloc] initWithUTF8String: (const char *)sqlite3_column_text(selectstatement, 0)];
        NSString *phone_field = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(selectstatement, 1)];
        address.text = address_field;
        phone.text = phone_field;
        status.text  = @"Match Found";

        
    } else {
        NSLog(@"%s",sqlite3_errmsg(contactDB));
        status.text = @"No Match Found!";
        name.text    = @"";
        address.text = @"";
        phone.text   = @"";
    }
    sqlite3_reset(selectstatement);
    sqlite3_clear_bindings(selectstatement);
}

@end
