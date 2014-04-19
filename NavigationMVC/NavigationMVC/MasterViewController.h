//
//  MasterViewController.h
//  NavigationMVC
//
//  Created by Saurav on 4/20/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController
{
    NSMutableArray *courses;
}

@property (nonatomic, assign) NSMutableArray *courses;
@end
