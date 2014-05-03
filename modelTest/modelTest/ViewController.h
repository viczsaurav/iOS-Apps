//
//  ViewController.h
//  modelTest
//
//  Created by student on 5/3/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController <CBCentralManagerDelegate>
{
    
}

@property (nonatomic, strong) CBCentralManager* bluetoothManager;


@end
