//
//  AJBeaconMonitor.h
//  AddSomeBeacon
//
//  Created by Alexandre Joly on 9/24/13.
//  Copyright (c) 2013 Alexandre Joly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class AJBeaconMonitor;

@protocol AJBeaconMonitorDelegate

@optional
- (void)beaconMonitorDidRangeBeacons:(AJBeaconMonitor*)beaconMonitor;

@end

@interface AJBeaconMonitor : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) id<AJBeaconMonitorDelegate> delegate;
@property (nonatomic, readonly) NSArray *beacons;

- (id)initWithUUID:(NSUUID*)uuid andIdentifier:(NSString*)identifier;

- (void)startMonitoring;
- (void)stopMonitoring;

@end

