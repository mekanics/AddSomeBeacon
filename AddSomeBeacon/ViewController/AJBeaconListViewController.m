//
//  AJBeaconListViewController.m
//  AddSomeBeacon
//
//  Created by Alexandre Joly on 24.09.13.
//  Copyright (c) 2013 Alexandre Joly. All rights reserved.
//

#import "AJBeaconListViewController.h"
#import "AJBeaconMonitor.h"

@interface AJBeaconListViewController ()

@property (nonatomic, retain) AJBeaconMonitor *beaconMonitor;

@end

@implementation AJBeaconListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle: @"Beacons"];

    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"60D481BE-D401-42F0-9760-B8296EE2CC5F"];
    NSString *identifier = @"MyBeacon";
    
    _beaconMonitor = [[AJBeaconMonitor alloc] initWithUUID:uuid andIdentifier:identifier];
    _beaconMonitor.delegate = self;
    
    [_beaconMonitor startMonitoring];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    CLBeacon *curBeacon = [_dataSource objectAtIndex:indexPath.row];

    cell.textLabel.text = [curBeacon.proximityUUID UUIDString];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%f m", curBeacon.accuracy];
    
    return cell;
}

#pragma mark - AJBeaconMonitorDelegate

- (void)beaconMonitorDidRangeBeacons:(AJBeaconMonitor *)beaconMonitor {
    _dataSource = [beaconMonitor.beacons copy];
    [self.tableView reloadData];
}

@end
