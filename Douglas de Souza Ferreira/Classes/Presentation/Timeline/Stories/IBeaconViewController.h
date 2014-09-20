//
//  IBeaconViewController.h
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 14/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import "BaseStoryViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface IBeaconViewController : BaseStoryViewController <CLLocationManagerDelegate>

#pragma mark - Properties
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) NSArray *detectedBeacons;
@property (nonatomic, copy) NSString *lastMessage;
@property (weak, nonatomic) IBOutlet UILabel *beaconStatusLabel;

@end
