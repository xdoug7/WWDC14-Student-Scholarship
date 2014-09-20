//
//  AppsViewController.m
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 14/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import "AppsViewController.h"

typedef enum : NSUInteger {
	AppTagATD3          = 1,
	AppTagCCDS          = 2,
	AppTagTHFFXIII      = 3,
	AppTagMuscled2      = 4,
	AppTagIba           = 5,
	AppTagRecliners     = 6
} AppTag;

@interface AppsViewController ()

@end

@implementation AppsViewController

- (IBAction)openOnAppStore:(UIButton *)sender {
	NSString *appURL;

	switch (sender.tag) {
		case AppTagATD3:
			appURL = @"https://itunes.apple.com/app/id580161892";
			break;

		case AppTagCCDS:
			appURL = @"https://itunes.apple.com/app/id604166319";
			break;

		case AppTagTHFFXIII:
			appURL = @"https://itunes.apple.com/app/id725149269";
			break;

		case AppTagMuscled2:
			appURL = @"https://itunes.apple.com/app/id563954750";
			break;

		case AppTagIba:
			appURL = @"https://itunes.apple.com/app/id462881742";
			break;

		case AppTagRecliners:
			appURL = @"https://itunes.apple.com/app/id789587370";
			break;

		default:
			break;
	}

	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURL]];
}

@end
