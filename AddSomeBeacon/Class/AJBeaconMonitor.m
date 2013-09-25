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

@property (nonatomic, retain) CLBeaconRegion *beaconRegion;
@property (nonatomic, retain) CLRegion *region;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end

@implementation AJBeaconMonitor

- (id)initWithRegion:(CLRegion*)region {
    
    if (self = [super init]) {
        _region = region;
        
        [self setup];
    }
    
    return self;
    
}

- (void)setup {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"a-very-awesome-uuid"];
    NSString *identifier = @"mmmhBeacon";
    
    _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:identifier];
    
    _locationManager = [CLLocationManager new];
    _locationManager.delegate = self;
}

- (void)startMonitoring {
    NSLog(@"startMonitoring");
    if (!isMonitoring) {
        [_locationManager startMonitoringForRegion:_beaconRegion];
        isMonitoring = YES;
    }
}

- (void)stopMonitoring {
    [_locationManager stopMonitoringForRegion:_beaconRegion];
    isMonitoring = NO;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"%@", locations);
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"didEnterRegion");
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"didExitRegion");
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"didRangeBeacons");
}
@end
