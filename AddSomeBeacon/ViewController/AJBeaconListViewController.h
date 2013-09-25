//
//  AJBeaconListViewController.h
//  AddSomeBeacon
//
//  Created by Alexandre Joly on 24.09.13.
//  Copyright (c) 2013 Alexandre Joly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AJBeaconMonitor.h"

@interface AJBeaconListViewController : UITableViewController <AJBeaconMonitorDelegate>

@property (nonatomic, retain) NSArray* dataSource;

@end
