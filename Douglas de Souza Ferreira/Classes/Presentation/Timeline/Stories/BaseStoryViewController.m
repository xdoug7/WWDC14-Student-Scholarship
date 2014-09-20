//
//  BaseStoryViewController.m
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 12/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import "BaseStoryViewController.h"
#import "UIImage+ImageEffects.h"

@interface BaseStoryViewController ()

@end

@implementation BaseStoryViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];

	// Set the background image to the blurred version
	self.backgroundImageView.image = [[self.delegate imageToBeBlurredWithSize:self.backgroundImageView.frame.size] applyLightEffect];

	// Update label with the story details
	self.titleLabel.text = self.story.title;
	self.informationLabel.text = self.story.information;
}

#pragma mark - Actions

- (IBAction)dismissModal:(UIBarButtonItem *)sender {
	[self dismissViewControllerAnimated:YES
	                         completion:nil];
}

@end
