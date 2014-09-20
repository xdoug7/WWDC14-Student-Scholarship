//
//  IBeaconViewController.m
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 14/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import "IBeaconViewController.h"

static NSString *const kProximityUUID = @"D57092AC-DFAA-446C-8EF3-C81AA22815B5";
static NSString *const kRegionLookupIdentifier = @"kDouglasBeaconKey";

@implementation IBeaconViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.detectedBeacons = [NSArray new];

	if (![CLLocationManager isRangingAvailable]) {
		NSLog(@"Warning: Ranging is not Available...");
		return;
	}

	if (self.locationManager.rangedRegions.count > 0) {
		return;
	}

	NSLog(@"Searching for Beacons...");
	[self.locationManager startRangingBeaconsInRegion:self.beaconRegion];

	self.beaconStatusLabel.font = [UIFont fontWithName:@"Avenir-Book" size:18.0f];
	self.beaconStatusLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
	self.beaconStatusLabel.numberOfLines = 0;
}

- (CLLocationManager *)locationManager {
	if (!_locationManager) {
		_locationManager = [[CLLocationManager alloc] init];
		_locationManager.delegate = self;
	}

	return _locationManager;
}

- (CLBeaconRegion *)beaconRegion {
	if (!_beaconRegion) {
		NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:kProximityUUID];
		_beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID
		                                                        major:1
		                                                        minor:0
		                                                   identifier:kRegionLookupIdentifier];
		_beaconRegion.notifyEntryStateOnDisplay = NO;
		_beaconRegion.notifyOnEntry = YES;
		_beaconRegion.notifyOnExit = YES;
	}
	return _beaconRegion;
}

#pragma mark - Location manager delegate methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
	if (![CLLocationManager locationServicesEnabled]) {
		NSLog(@"Couldn't turn on ranging: Location services are not enabled.");
	}

	if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized) {
		NSLog(@"Couldn't turn on monitoring: Location services not authorised.");
	}
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
	if (beacons.count == 0) {
		NSLog(@"No beacons found.");
	}
	else {
		for (CLBeacon *beacon in beacons) {
			self.beaconStatusLabel.text = [self detailsStringForBeacon:beacon];
		}
	}
	self.detectedBeacons = beacons;
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
	NSLog(@"monitoringDidFailForRegion - error: %@", [error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
	[self.locationManager startRangingBeaconsInRegion:self.beaconRegion];

	NSLog(@"didEnterRegion: %@", region);
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
	[self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
	NSLog(@"Region Exited: %@", region);
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
	NSString *stateString = nil;
	switch (state) {
		case CLRegionStateInside:
			stateString = @"inside";
			break;

		case CLRegionStateOutside:
			stateString = @"outside";
			break;

		case CLRegionStateUnknown:
			stateString = @"unknown";
			break;
	}

	NSLog(@"State changed to %@ for region %@.", stateString, region);
	self.beaconStatusLabel.text = [NSString stringWithFormat:@"State changed to %@ for region %@.", stateString, region];
}

- (NSString *)detailsStringForBeacon:(CLBeacon *)beacon {
	NSString *proximity;
	switch (beacon.proximity) {
		case CLProximityNear:
			proximity = @"Warm";
			break;

		case CLProximityImmediate:
			proximity = @"Hot!";
			break;

		case CLProximityFar:
			proximity = @"Cold";
			break;

		case CLProximityUnknown:
		default:
			proximity = @"Freezing!";
			break;
	}

	return [NSString stringWithFormat:@"Proximity: %@", proximity];
}

@end
