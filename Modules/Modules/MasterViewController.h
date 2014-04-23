//
//  MasterViewController.h
//  Modules
//
//  Created by Saurav on 23/4/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class ModulesModel;

@interface MasterViewController : UITableViewController

@property (nonatomic,retain) DetailViewController *detailViewController;
@property (strong,nonatomic) ModulesModel *modulesModel;

@end
