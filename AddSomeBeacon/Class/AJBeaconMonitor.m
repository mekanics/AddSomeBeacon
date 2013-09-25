//
//  AJBeaconMonitor.m
//  AddSomeBeacon
//
//  Created by Alexandre Joly on 9/24/13.
//  Copyright (c) 2013 Alexandre Joly. All rights reserved.
//

#import "AJBeaconMonitor.h"

#import <CoreLocation/CLBeaconRegion.h>

@interface AJBeaconMonitor () {
    BOOL isMonitoring;
}

@property (nonatomic, retain) NSUUID *uuid;
@property (nonatomic, retain) NSString *identifier;

@property (nonatomic, retain) CLBeaconRegion *beaconRegion;
@property (nonatomic, retain) CLRegion *region;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end

@implementation AJBeaconMonitor

- (id)initWithUUID:(NSUUID*)uuid andIdentifier:(NSString*)identifier {
    
    if (self = [super init]) {
        _uuid = uuid;
        _identifier = identifier;
        
        [self setup];
    }
    
    return self;
    
}

- (void)setup {
    _beacons = [[NSArray alloc] init];

    _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:_uuid identifier:_identifier];

    _beaconRegion.notifyEntryStateOnDisplay = YES;
    _beaconRegion.notifyOnEntry = YES;
    _beaconRegion.notifyOnExit = YES;


    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
}

- (void)startMonitoring {
    NSLog(@"startMonitoring");
    [_locationManager startMonitoringForRegion:_beaconRegion];
    isMonitoring = YES;
}

- (void)stopMonitoring {
    NSLog(@"stopMonitoring");
    [_locationManager stopMonitoringForRegion:_beaconRegion];
    isMonitoring = NO;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"didEnterRegion");

    if ([region.identifier isEqualToString:@"MyBeacon"]) {
        [_locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"didExitRegion");

    [_locationManager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"didRangeBeacons");

    if ([beacons count] > 0) {
        CLBeacon *nearest = [beacons objectAtIndex:0];
        if (CLProximityImmediate == nearest.proximity) {
            NSLog(@"immediate");
        } else if (CLProximityNear == nearest.proximity) {
            NSLog(@"near");
        } else if (CLProximityFar == nearest.proximity) {
            NSLog(@"far");
        } else if (CLProximityUnknown == nearest.proximity) {
            NSLog(@"unknow");
        }

        NSLog(@"rssi: %d", nearest.rssi);

    } else {
        NSLog(@"not beacons");
    }

    _beacons = [beacons copy];

    if (_delegate)
        [_delegate beaconMonitorDidRangeBeacons:self];

}
@end
