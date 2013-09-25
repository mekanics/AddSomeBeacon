//
//  AJBeaconMonitor.h
//  AddSomeBeacon
//
//  Created by Alexandre Joly on 9/24/13.
//  Copyright (c) 2013 Alexandre Joly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AJBeaconMonitor : NSObject <CLLocationManagerDelegate>

- (id)initWithRegion:(CLRegion*)region;
- (void)startMonitoring;
- (void)stopMonitoring;

@end
